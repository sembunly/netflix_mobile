//
//  Trailer.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation

struct TrailerResponse: Decodable {
    let results: [Trailer]
}

struct Trailer: Decodable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String

    var youtubeURL: URL? {
        guard site == "YouTube" else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
