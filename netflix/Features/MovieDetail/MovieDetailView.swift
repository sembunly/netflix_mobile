//
//  MovieDetailView.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import SwiftUI
import WebKit

struct MovieDetailView: View {
    let movie: Movie

    @State private var trailer: Trailer?
    @State private var isLoadingTrailer = true
    @State private var trailerError: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                AsyncImage(url: movie.backdropURL ?? movie.posterURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().fill(Color(white: 0.16))
                }
                .frame(height: 240)
                .frame(maxWidth: .infinity)
                .clipped()

                VStack(alignment: .leading, spacing: 14) {
                    Text(movie.title)
                        .font(.largeTitle.bold())

                    HStack(spacing: 16) {
                        if let date = movie.releaseDate, !date.isEmpty {
                            Text(String(date.prefix(4)))
                        }
                        if let rating = movie.voteAverage {
                            Label(String(format: "%.1f", rating), systemImage: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                    Text(movie.overview.isEmpty ? "No description available." : movie.overview)
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.82))

                    trailerSection
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 28)
            }
        }
        .background(Color.black)
        .foregroundStyle(.white)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task { await loadTrailer() }
    }

    @ViewBuilder
    private var trailerSection: some View {
        if let key = trailer?.key {
            VStack(alignment: .leading, spacing: 12) {
                Text("Trailer").font(.title3.bold())
                YouTubePlayerView(videoID: key)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 8)
        } else if isLoadingTrailer {
            ProgressView("Loading trailer")
                .tint(.white)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 120)
        } else {
            Text(trailerError ?? "No trailer is available for this movie.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    @MainActor
    private func loadTrailer() async {
        defer { isLoadingTrailer = false }
        do {
            trailer = try await YouTubeService().trailer(for: movie.id)
            if trailer == nil { trailerError = "No trailer is available for this movie." }
        } catch {
            trailerError = error.localizedDescription
        }
    }
}

private struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let escapedID = videoID.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        let html = """
        <!doctype html><html><head><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"></head>
        <body style="width:100%;height:100%;margin:0;background:#000"><iframe style="width:100%;height:100%;border:0" src="https://www.youtube-nocookie.com/embed/\(escapedID)?playsinline=1" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></body></html>
        """
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
    }
}
