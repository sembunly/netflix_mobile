//
//  APIClient.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation

enum APIError: LocalizedError {
    case missingAPIKey
    case invalidResponse
    case httpStatus(Int)

    var errorDescription: String? {
        switch self {
        // case .missingAPIKey: return "Add TMDB_API_KEY to your local Secrets.xcconfig file to load movies."
        case .missingAPIKey: return ""
        case .invalidResponse: return "The server returned an invalid response."
        case .httpStatus(let code): return "The movie service returned an error (HTTP \(code))."
        }
    }
}

struct APIClient {
    func get<T: Decodable>(_ path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard APIConfig.isConfigured else { throw APIError.missingAPIKey }
        guard var components = URLComponents(url: APIConfig.baseURL.appending(path: path), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidResponse
        }
        components.queryItems = [URLQueryItem(name: "api_key", value: APIConfig.apiKey)] + queryItems
        guard let url = components.url else { throw APIError.invalidResponse }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        guard (200..<300).contains(response.statusCode) else { throw APIError.httpStatus(response.statusCode) }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
