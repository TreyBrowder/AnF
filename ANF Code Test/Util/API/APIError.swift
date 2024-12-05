//
//  APIError.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidCode(code: Int)
    case JSONParseError
    case invalidData(msg: String)
    case unknown(error: Error)
    
    var errMsg: String {
        switch self {
            
        case .invalidURL:
            return "Debug - Log: Invalid URL"
        case .invalidResponse:
            return "Debug - Log: Invalid Response"
        case .invalidCode(code: let code):
            return "Debug - Log: Invalid Response Code - \(code)"
        case .JSONParseError:
            return "Debug - Log: JSON Parsing Error"
        case .invalidData(msg: let msg):
            return "Debug - Log: Invalid Data - \(msg)"
        case .unknown(error: let error):
            return "Debug - Log: Unknown Error Occurred - \(error.localizedDescription)"
        }
    }
}
