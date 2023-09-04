//
//  APIError.swift
//  MLGtest
//
//  Created by Amr Adel on 06/07/2023.
//

import Foundation

enum APIError: Error {
    
    case noInternetConnection
    case badRequest
    case unAuthenticated
    case serverError
    case decodingFailed
    case unknown
    
}
