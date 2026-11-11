//
//  MovieCardView.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color(white: 0.16)).overlay {
                    Image(systemName: "film").foregroundStyle(.gray)
                }
            }
            .frame(height: 220)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(movie.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .lineLimit(2)
        }
    }
}
