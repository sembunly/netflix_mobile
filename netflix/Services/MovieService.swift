//
//  MovieService.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation

struct MovieService {
    private let client = APIClient()

    func movies(for category: MovieCategory.Kind) async throws -> [Movie] {
        let response: MovieListResponse = try await client.get("movie/\(category.endpoint)", queryItems: [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ])
        return response.results
    }
}

struct MovieCategory: Identifiable {
    enum Kind: String, CaseIterable, Identifiable {
        case popular, topRated, nowPlaying, upcoming

        var id: String { endpoint }
        var endpoint: String {
            switch self {
            case .popular: return "popular"
            case .topRated: return "top_rated"
            case .nowPlaying: return "now_playing"
            case .upcoming: return "upcoming"
            }
        }
        var title: String {
            switch self {
            case .popular: return "Popular on Netflix"
            case .topRated: return "Top Rated"
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Coming Soon"
            }
        }
    }

    let kind: Kind
    let movies: [Movie]
    var id: Kind { kind }
    var title: String { kind.title }
}
