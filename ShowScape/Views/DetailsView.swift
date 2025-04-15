import SwiftUI

struct DetailsView: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var favoritesVM: FavoritesViewModel

    var movie: Movie
    let isFromFavorites: Bool


    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        ZStack {
            Color("mikadoYellow")
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                    AsyncImage(url: movie.posterPathImage) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .shadow(color: .black, radius: 1, x: 5, y: 3)
                            .padding(5)
                    } placeholder: {
                        Image("filmBand")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .shadow(color: .white, radius: 1, x: 5, y: 3)
                            .padding(5)
                    }
                }
                .navigationTitle(movie.title ?? "Untitled")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        favoriteButton()
                    }
                }


                ScrollView {
                    Spacer().frame(height: 25)
                    
                    VStack(spacing: 25) {
                        HStack {
                            VStack(alignment: .leading, spacing: 20) {
                                SectionHeaderView(text: "Original title :")
                                SectionContentView(text: movie.title ?? "N/A")
                                
                                SectionHeaderView(text: "Original language :")
                                SectionContentView(text: movie.originalLanguage ?? "No result")
                                
                                SectionHeaderView(text: "Synopsis :")
                                SectionContentView(text: movie.overview ?? "No result")
                                
                                SectionHeaderView(text: "Release :")
                                SectionContentView(text: movie.releaseDate ?? "No result")
                                
                                SectionHeaderView(text: "Cast :")
                                if let credits = viewModel.movieCredits {
                                    ForEach(credits.cast) { actor in
                                        HStack(alignment: .center) {
                                            if let path = actor.profilePath {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(path)")) { image in
                                                    image.resizable()
                                                        .scaledToFit()
                                                        .clipShape(Circle())
                                                        .frame(width: 50, height: 50)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            } else {
                                                Image(systemName: "person.circle.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .clipShape(Circle())
                                                    .frame(width: 50, height: 50)
                                            }
                                            Text(actor.name)
                                        }
                                    }
                                } else {
                                    ProgressView()
                                        .onAppear {
                                            viewModel.fetchMovieCredits(movieId: movie.id)
                                        }
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onAppear {
                    viewModel.fetchMovieCredits(movieId: movie.id)
                }
            }
        }
    }
    private func favoriteButton() -> some View {
        Button {
            favoritesVM.toggleFavorite(for: movie)

            // Si le film a été retiré des favoris
            if !favoritesVM.isFavorite(movie) {
                if isFromFavorites {
                    // Si la vue actuelle est la FavoritesView, revenir en arrière
                    dismiss()
                } else {
                    // Sinon, mettre à jour le binding pour d'autres vues
                    isPresented = false
                }
            }
        } label: {
            Image(systemName: favoritesVM.isFavorite(movie) ? "heart.fill" : "heart")
                .foregroundColor(.red)
        }
    }

}




struct DetailsView_Previews: PreviewProvider {
    @State static var isPresented = true

    static var previews: some View {
        PreviewWrapper {
            DetailsView(
                isPresented: $isPresented,
                movie: Movie(
                    adult: false,
                    backdropPath: "/path/to/backdrop.jpg",
                    genreIDS: [28, 12],
                    id: 1,
                    originalLanguage: "en",
                    originalTitle: "Example Movie",
                    overview: "This is an example movie overview.",
                    popularity: 7.5,
                    posterPath: "/path/to/poster.jpg",
                    releaseDate: "2024-01-01",
                    title: "Example Movie",
                    video: false,
                    voteAverage: 8.0,
                    voteCount: 120
                ), isFromFavorites: false
            )
        }
    }
}

struct PreviewWrapper<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        content()
            .environmentObject(FavoritesViewModel())
    }
}

struct SectionHeaderView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("Raleway", size: 20))
            .fontWeight(.semibold)
            .shadow(color: .white, radius: 1, x: 3, y: 2)
        
            .padding(15)
            .background(Color.white.opacity(1.0))
            .clipShape(RoundedRectangle(cornerRadius: 30.0))
            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.black, lineWidth: 2)
            )
    }
}

struct SectionContentView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("Raleway", size: 22))
            .fontWeight(.regular)
            .shadow(color: .white, radius: 1, x: 3, y: 2)
            .padding(15)
    }
}

struct SectionCastView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("Raleway", size: 20))
            .fontWeight(.regular)
            .padding(10)
            .background(Color.white.opacity(1.0)) // Fond blanc légèrement transparent
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
        
    }
}
