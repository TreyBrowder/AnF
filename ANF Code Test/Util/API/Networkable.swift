//
//  Networkable.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import Foundation

protocol Networkable {
    func fetchData<T: Decodable>(as type: T.Type, with endpoint: String) async throws -> T
}

extension Networkable {
    func fetchData<T: Decodable>(as type: T.Type, with endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else { throw APIError.invalidURL }
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let res = resp as? HTTPURLResponse else { throw APIError.invalidResponse }
        guard (200...299).contains(res.statusCode) else { throw APIError.invalidCode(code: res.statusCode) }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw error as? APIError ?? .unknown(error: error)
        }
        
    }
}

