//
//  YouTubeService.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation

struct YouTubeService {
    private let client = APIClient()

    func trailer(for movieID: Int) async throws -> Trailer? {
        let response: TrailerResponse = try await client.get("movie/\(movieID)/videos")
        return response.results.first { $0.site == "YouTube" && $0.type == "Trailer" }
            ?? response.results.first { $0.site == "YouTube" }
    }
}
