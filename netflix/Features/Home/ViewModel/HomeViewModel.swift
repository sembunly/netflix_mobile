//
//  HomeViewModel.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var categories: [MovieCategory] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service = MovieService()

    func loadMovies() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let movieService = service
            let results = try await withThrowingTaskGroup(of: MovieCategory.self) { group in
                for kind in MovieCategory.Kind.allCases {
                    group.addTask {
                        MovieCategory(kind: kind, movies: try await movieService.movies(for: kind))
                    }
                }
                var categories: [MovieCategory] = []
                for try await category in group { categories.append(category) }
                return categories.sorted { $0.kind.allCasesIndex < $1.kind.allCasesIndex }
            }
            categories = results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

private extension MovieCategory.Kind {
    var allCasesIndex: Int { MovieCategory.Kind.allCases.firstIndex(of: self) ?? 0 }
}
