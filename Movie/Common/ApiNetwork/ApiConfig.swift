//
//  ApiConfig.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import Foundation

public struct ApiRequestConfiguration {
    public var path: String = ""
    public var method: Method = .get // Default to GET
    public var body: Data? = nil
    public var headers: [String: String] = [:]
    public var queryItems: [QueryModel] = []
    public var serverType: ServerType = .api // Default to API server

    public struct QueryModel {
        var key: String
        var value: String?
    }
    
    public enum Method: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    public enum ServerType {
        case api
        case image
    }

    // Fetch the correct base URL from the Info.plist based on the server type
    func getHost() -> String {
        let key: String
        switch serverType {
        case .api:
            key = "ApiServerUrl"
        case .image:
            key = "ImageServerUrl"
        }

        guard let serverURL = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Server URL for \(serverType) not found in Info.plist")
        }
        return serverURL
    }

    // Add custom headers to the request
    public mutating func addCustomHeader(key: String, value: String) {
        headers[key] = value
    }

    // Add query parameters to the request
    public mutating func addQueryItem(key: String, value: String?) {
        let newQuery = QueryModel(key: key, value: value)
        queryItems.append(newQuery)
    }

    // Add request body (for POST, PUT, etc.)
    public mutating func addRequestBody<TRequest>(_ body: TRequest?,
                                                  _ keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys)
    where TRequest: Encodable {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy
        self.body = try? encoder.encode(body)
    }
    
    // Construct the full URL with the query parameters
    public func getUrl() -> URL? {
        guard var urlComponents = URLComponents(string: getHost()) else {
            return nil
        }
        urlComponents.path = path

        urlComponents.queryItems = queryItems.map {
            return URLQueryItem(name: $0.key, value: $0.value)
        }

        urlComponents.percentEncodedQuery = urlComponents
            .percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")

        return urlComponents.url?.absoluteURL
    }
}
