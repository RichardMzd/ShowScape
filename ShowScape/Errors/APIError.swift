//
//  APIError.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 20/08/2024.
//

import Foundation

enum APIError: Error {
    
    case invalidURL
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid Error, look the url and try again."
        }
    }
}
