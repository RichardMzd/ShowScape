//
//  FavoriteRow.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 14/04/2025.
//

import SwiftUI

struct FavoriteRow: View {
    @Binding var favorite: Favorite

    var body: some View {
        HStack(spacing: 12) {
            if let path = favorite.posterpath,
               let url = URL(string: "https://image.tmdb.org/t/p/w200\(path)") {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(favorite.title ?? "No title")
                    .font(.headline)
                    .foregroundColor(.black)
                Text(favorite.overview ?? "")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
    }
}









