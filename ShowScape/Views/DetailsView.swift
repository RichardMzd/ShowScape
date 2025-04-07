import SwiftUI

struct DetailsView: View {
    @Binding var isPresented: Bool
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss // Pour gérer le retour

    
    var movie: Result
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
                                .aspectRatio(contentMode: .fit )
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .shadow(color: .white, radius: 1, x: 5, y: 3)
                                .padding(5)
                        }
                    }
                    .navigationTitle(movie.title ?? "Untitled")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing ) {
                            Button {
                                print("Tapped on")
                            } label: {
                                Image(systemName: "star")
                                    .foregroundColor(.black)
                            }
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
    
    struct DetailsView_Previews: PreviewProvider {
        @State static var isPresented = true
        
        static var previews: some View {
            DetailsView(isPresented: $isPresented,
                movie: Result(
                    adult: false,
                    backdropPath: "/path/to/backdrop.jpg",
                    genreIDS: [28, 12], // Exemple de genres
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
                )
            )
        }
    }
