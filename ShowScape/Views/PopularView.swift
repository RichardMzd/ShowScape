//
//  PopularView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 20/05/2024.
//

import SwiftUI
import Combine

import SwiftUI

struct PopularView: View {

    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject var movieViewModel = MovieViewModel()

    var title: String
    
    init(isPresented: Binding<Bool>, title: String) {
        self._isPresented = isPresented
        self.title = title
        ToolBarAppearance.configureNavigationBarAppearance(
            backgroundColor: UIColor(named: "mikadoYellow") ?? .yellow,
            titleColor: .black
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("mikadoYellow")
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(movieViewModel.popular) { movie in
                            NavigationLink(destination: DetailsView(isPresented: $isPresented, movie: movie, isFromFavorites: false)) {
                                MovieCardView(movie: movie) {
                                    movieViewModel.loadMoreMoviesIfNeeded(
                                        currentMovie: movie,
                                        movies: movieViewModel.popular
                                    ) {
                                        movieViewModel.getPopularPosts(page: movieViewModel.currentPage + 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Home")
//                        }
//                        .padding(8)
//                        .font(.custom("Raleway-Bold", size: 15))
//                        .shadow(color: .white, radius: 0, x: 3, y: 2)
//                        .foregroundColor(.black)
//                        .background(Color.white)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(.black, lineWidth: 4)
//                        )
//                        .cornerRadius(10)
//                        .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
//                    }
//                }
//
//                ToolbarItem(placement: .principal) {
//                    Text(title)
//                        .font(.custom("Raleway", size: 20))
//                        .bold()
//                        .shadow(color: .white, radius: 0, x: 3, y: 2)
//                }
//            }
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    }
}

struct MovieCardView: View {
    let movie: Movie
    let onAppear: () -> Void

    var body: some View {
        VStack {
            AsyncImage(url: movie.posterPathImage) { phase in
                switch phase {
                case .empty:
                    defaultImage
                case .success(let image):
                    imageView(image)
                case .failure:
                    defaultImage
                @unknown default:
                    defaultImage
                }
            }

            Text(movie.title ?? "Untitled")
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .lineLimit(2)
                .truncationMode(.tail)
                .frame(maxWidth: 140)
                .multilineTextAlignment(.center)
        }
        .onAppear(perform: onAppear)
    }

    private var defaultImage: some View {
        Image("defaultImage")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 140, height: 240)
            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
    }

    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 140, height: 240)
            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView(isPresented: .constant(false), title: "Popular")
    }
}


