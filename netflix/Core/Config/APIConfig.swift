//
//  APIConfig.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation

enum APIConfig {
    static let baseURL = URL(string: "https://api.themoviedb.org/3")!
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")!

    static let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String ?? ""
    static var isConfigured: Bool { !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}
