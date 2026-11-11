//
//  Movie.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    var posterURL: URL? { imageURL(for: posterPath) }
    var backdropURL: URL? { imageURL(for: backdropPath) }

    private func imageURL(for path: String?) -> URL? {
        guard let path else { return nil }
        return URL(string: path, relativeTo: APIConfig.imageBaseURL)
    }
}

struct MovieListResponse: Decodable {
    let results: [Movie]
}
