//
//  ApiError.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import Foundation

public enum APIError: Error, CustomStringConvertible, Equatable {
    case badRequest(message: String?)
    case invalidURL
    case authentication
    case notFound(url: String?)
    case rateLimitExceeded
    case serverError(message: String)
    case notAuthorized
    case customError(message: String?)
    
    public var code: Int {
        switch self {
        case .badRequest:
            return 400
        case .invalidURL:
            return 400
        case .authentication:
            return 401
        case .notFound:
            return 404
        case .rateLimitExceeded:
            return 429
        case .serverError:
            return 500
        case .notAuthorized:
            return 403
        case .customError:
            return 400
        }
    }

    public var message: String {
        switch self {
        case .badRequest(let message):
            return "Bad Request: \(message ?? "Unknown error")"
        case .invalidURL:
            return "Invalid URL"
        case .authentication:
            return "Authentication Failed"
        case .notFound(let url):
            return "Resource not found: \(url ?? "Unknown URL")"
        case .rateLimitExceeded:
            return "Rate Limit Exceeded"
        case .serverError(let message):
            return "Server Error: \(message)"
        case .notAuthorized:
            return "Not Authorized"
        case .customError(let message):
            return message ?? "An error occurred"
        }
    }

    public var description: String {
        return "Error \(code): \(message)"
    }
}
