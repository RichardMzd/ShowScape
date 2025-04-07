//
//  MovieScrollView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 22/08/2024.
//

import SwiftUI

struct MovieScrollView<Destination: View>: View {
    var movies: [Result]
    var destination: (Result) -> Destination
    
    @StateObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(movies) { movie in
                    VStack(alignment: .center, spacing: 10) {
                        NavigationLink(destination: destination(movie)) {
                            ZStack(alignment: .topTrailing) {
                                AsyncImage(url: movie.posterPathImage) { phase in
                                    switch phase {
                                    case .empty:
                                        Image("filmBand")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .frame(width: 140, height: 240)
                                            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .frame(width: 140, height: 240)
                                            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                    case .failure:
                                        Image("filmBand")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .frame(width: 140, height: 240)
                                            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                    @unknown default:
                                        Image("filmBand")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .frame(width: 140, height: 240)
                                            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                    }
                                }
                                
                                Text(String(format: "%.1f", movie.voteAverage ?? 5))
                                    .font(.custom("Raleway", size: 15))
                                    .bold()
                                    .shadow(color: .white, radius: 0, x: 1, y: 1)
                                    .padding(15)
                                    .background(Color("mikadoYellow"))
                                    .foregroundColor(.black)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(.black, lineWidth: 5)
                                    )
                                    .cornerRadius(35)
                                    .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                    .offset(x: 10, y: -10)
                                
                            }
                        }
                        
                        Text(movie.title ?? "Title not found")
                            .fontWeight(.bold)
                            .font(.custom("Raleway", size: 15))
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .frame(maxWidth: 140)
                            .multilineTextAlignment(.center)
                    }
                    
                }
            }
            .padding()
        }
    }
}

// Extension pour créer un mock
extension Result {
    static func mock() -> Result {
        return Result(adult: true,
                      backdropPath: "movie",
                      genreIDS: [12],
                      id: 1,
                      originalLanguage: "French",
                      originalTitle: "Mock",
                      overview: "Good",
                      popularity: 25.0,
                      posterPath: "https://example.com/poster.jpg",
                      releaseDate: "1993",
                      title: "Mock Movie Title",
                      video: true,
                      voteAverage: 7.5,
                      voteCount: 12)
    }
}

// Prévisualisation avec des données mock
struct MovieScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieScrollView(movies: [Result.mock(), Result.mock(), Result.mock()]) { movie in
            DetailsView(isPresented: .constant(false), movie: movie) // Assurez-vous que `DetailsView` accepte `Result` comme argument
        }
    }
}

