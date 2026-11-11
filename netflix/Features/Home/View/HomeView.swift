//
//  HomeView.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    private var featuredMovie: Movie? {
        viewModel.categories.first(where: { $0.kind == .popular })?.movies.first
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    header

                    if let featuredMovie {
                        featuredBanner(featuredMovie)
                    }

                    if viewModel.isLoading && viewModel.categories.isEmpty {
                        ProgressView("Loading movies")
                            .tint(.white)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 220)
                    } else if let error = viewModel.errorMessage, viewModel.categories.isEmpty {
                        ContentUnavailableView {
                            Label("Movies unavailable", systemImage: "wifi.exclamationmark")
                        } description: {
                            Text(error)
                        } actions: {
                            Button("Try again") { Task { await viewModel.loadMovies() } }
                                .buttonStyle(.borderedProminent)
                                .tint(.red)
                        }
                        .foregroundStyle(.white)
                    } else {
                        ForEach(viewModel.categories) { category in
                            movieRow(category)
                        }
                    }
                }
                .padding(.bottom, 28)
            }
            .background(Color.black)
            .ignoresSafeArea(edges: .top)
            .refreshable { await viewModel.loadMovies() }
            .navigationDestination(for: Movie.self) { MovieDetailView(movie: $0) }
            .toolbar(.hidden, for: .navigationBar)
            .task { await viewModel.loadMovies() }
        }
        .tint(.red)
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack {
            NetflixLogo()
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 18)
        .padding(.top, 58)
        .padding(.bottom, 4)
    }

    private func featuredBanner(_ movie: Movie) -> some View {
        NavigationLink(value: movie) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: movie.backdropURL ?? movie.posterURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().fill(Color(white: 0.15))
                }
                .frame(height: 470)
                .frame(maxWidth: .infinity)
                .clipped()

                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.2),
                        .init(color: .black.opacity(0.5), location: 0.55),
                        .init(color: .black, location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text(movie.title)
                        .font(.system(size: 30, weight: .bold))
                        .lineLimit(2)
                    Text(movie.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                        .foregroundStyle(.white.opacity(0.85))
                    HStack(spacing: 12) {
                        Label("Play", systemImage: "play.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.black)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 10)
                            .background(.white, in: RoundedRectangle(cornerRadius: 5))

                        Label("More Info", systemImage: "info.circle")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.24), in: RoundedRectangle(cornerRadius: 5))
                    }
                }
                .padding(18)
            }
            .frame(height: 470)
            .foregroundStyle(.white)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private func movieRow(_ category: MovieCategory) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(category.title)
                .font(.title3.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 18)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(category.movies) { movie in
                        NavigationLink(value: movie) {
                            MovieCardView(movie: movie)
                                .frame(width: 132)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 18)
            }
        }
    }
}
