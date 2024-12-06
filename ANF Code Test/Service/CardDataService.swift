//
//  CardDataService.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import UIKit

protocol CardDataProtocol: Sendable {
    func fetchCardData() async throws -> [ExploreCard]
    func fetchImage(for url: String) async throws -> UIImage
}

actor CardDataService: Networkable, CardDataProtocol {
    
    var baseURL: URLComponents {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "www.abercrombie.com"
        components.path = "/anf/nativeapp/qa/"
        
        return components
    }
    
    var allCardsUrlStr: String? {
        var components = baseURL
        components.path += "codetest/codeTest_exploreData.css"
        
        return components.url?.absoluteString
    }
    
    func fetchCardData() async throws -> [ExploreCard] {
        guard let endpoint = allCardsUrlStr else { throw APIError.invalidURL }
        return try await fetchData(as: [ExploreCard].self, with: endpoint)
    }
    
    func fetchImage(for url: String) async throws -> UIImage {
        return try await fetchImage(from: url)
    }
}
