//
//  ApiNetwork.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import SwiftUI

open class ApiNetwork {
    public var config: ApiRequestConfiguration
    let session: URLSession
    
    public init() {
        config = ApiRequestConfiguration()
        session = URLSession(configuration: .default)
    }
    
    public func apiCall<T: Decodable>() async throws -> T {
        do {
            let data = try await performRequest()
            
            // If T is Data, return the data directly
            if T.self == Data.self {
                return data as! T
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.serverError(message: "Serialization Error")
        }
    }
    
    private func performRequest() async throws -> Data {
        guard let url = config.getUrl() else {
            throw APIError.invalidURL
        }
        
        return try await doTask(request: createRequest(url: url, method: config.method))
    }
    
    private func createRequest(url: URL, method: ApiRequestConfiguration.Method) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        /*
         For testing purposes only, the API token is hardcoded directly into the ApiNetwork class. In real scenereos,
         this practice should be avoided due to security concerns.
         Instead, sensitive data like API keys or tokens should be stored securely, for example, in environment variables or a secure keychain,
         and never committed to source control.
         But as we don't have a login to get any access token, we use it straightforward
         */
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZmFhMjNmNDBhNzhjOTgzNTRiMTQ4NDEwNzgyOWFlMCIsIm5iZiI6MTcyNTQxNDg3MC43NDE5NDMsInN1YiI6IjY2ZDdiYzY1MzYwODBmNzk0ZDBlZDI5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WBnYcLJUOlvi7CoqYhyItbtkBafgJkL2-wQ9rSYfHzc"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Add request body if needed
        if let body = config.body {
            request.httpBody = body
        }
        
        return request
    }
    
    private func doTask(request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(message: "Invalid status code")
        }
        
        return data
    }
}
