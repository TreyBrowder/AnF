//
//  MockCardDataService.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/6/24.
//

import UIKit

final class MockCardDataService: Sendable, Networkable, CardDataProtocol {
    let mockData: Data?
    let mockError: APIError?
    
    init(mockData: Data? = nil, mockError: APIError? = nil) {
        self.mockData = mockData
        self.mockError = mockError
    }
    
    func fetchCardData() async throws -> [ExploreCard] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        if let error = mockError { throw error }
        
        do {
            let result = try JSONDecoder().decode([ExploreCard].self, from: mockData ?? testCardData)
            return result
        } catch {
            throw APIError.JSONParseError
        }
    }
    
    func fetchImage(for imgStr: String) async throws -> UIImage {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        if let error = mockError { throw error }
        
        guard let image = UIImage(named: imgStr) else {
            throw APIError.invalidData(msg: "Failed to create UIImage")
        }
        return image
    }
    
    func fetchData<T: Decodable>(as type: T.Type, with endpoint: String) async throws -> T {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        if let error = mockError { throw error }
        
        guard let data = mockData else {
            throw APIError.invalidData(msg: "No mock data provided")
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw APIError.JSONParseError
        }
    }
}
