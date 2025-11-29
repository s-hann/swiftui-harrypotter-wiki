//
//  APIClient.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct APIClient {
    static func fetch<T: Decodable>(
        path: String,
        queryItems: [URLQueryItem]? = nil,
        method: HTTPMethod = .get
    ) async throws -> T {
        let baseUrl = AppEnvironment.apiBaseURL
        let url = baseUrl.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIError.invalidURL
        }
        
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        
        guard let finalUrl = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown(URLError(.badServerResponse))
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed(statusCode: httpResponse
                .statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            #if DEBUG
            print ("Decoding error for \(path): \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(jsonString)")
            }
            #endif
            throw APIError.decodingFailed(error)
        }
        
        
        
        
    }
}
