//
//  MovieVerticalListView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/04/2025.
//

import SwiftUI

struct MovieVerticalListView: View {
    let movies: [Result]
    let onTap: (Result) -> DetailsView
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(movies) { movie in
                NavigationLink(destination: onTap(movie)) {
                    HStack(spacing: 12) {
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
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
