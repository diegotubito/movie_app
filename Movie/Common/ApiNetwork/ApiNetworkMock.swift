//
//  ApiNetworkMock.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import Foundation

open class ApiNetworkMock {
    public var mockFileName: String = ""
    var success: Bool = true
    
    public init() {
    }
    
    var error: APIError?
    
    public func apiCallMocked<T: Decodable>(bundle: Bundle) async throws -> T {
        let filenameFromTestingTarget = ProcessInfo.processInfo.environment["FILENAME"] ?? ""
        if !filenameFromTestingTarget.isEmpty {
            mockFileName = filenameFromTestingTarget
        }
        
        let testFail = ProcessInfo.processInfo.arguments.contains("-testFail")
        if testFail {
            success = testFail
        }
        
        guard let data = readLocalFile(bundle: bundle, forName: mockFileName) else {
            throw APIError.customError(message: "No such a file")
        }
        
        if !success {
            throw APIError.mockFailed
        }
        let json = try? JSONSerialization.jsonObject(with: data)
        print(json)
        // Configuración del JSONDecoder con la estrategia de snake_case
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let register = try? decoder.decode(T.self, from: data) else {
            throw APIError.serialization
        }
        
        return register
    }
    
    private func readLocalFile(bundle: Bundle, forName name: String) -> Data? {
        guard let bundlePath = bundle.path(forResource: name, ofType: "json") else {
            return nil
        }
        
        return try? String(contentsOfFile: bundlePath).data(using: .utf8)
    }
    
}



