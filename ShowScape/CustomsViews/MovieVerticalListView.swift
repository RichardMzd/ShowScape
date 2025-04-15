//
//  MovieVerticalListView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/04/2025.
//

import SwiftUI

struct MovieVerticalListView: View {
    let movies: [Movie]
    let onTap: (Movie) -> DetailsView

    var body: some View {
        VStack(spacing: 16) {
            ForEach(movies) { movie in
                NavigationLink(destination: onTap(movie)) {
                    HStack(spacing: 8) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                            image.resizable()
                        } placeholder: {
                            Image("filmBand")
                                .resizable()
                        }
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title ?? "No title")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(movie.overview ?? "")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                        }

                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}

