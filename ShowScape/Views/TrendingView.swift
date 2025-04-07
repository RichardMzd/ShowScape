import SwiftUI

struct TrendingView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss // Pour gérer le retour
    @StateObject var movieViewModel = MovieViewModel()
    
    var title: String // Ajout du titre comme paramètre
    
    init(isPresented: Binding<Bool>, title: String) {
            self._isPresented = isPresented
            self.title = title
            
            // Configure la barre de navigation via ToolBarAppearance
            ToolBarAppearance.configureNavigationBarAppearance(
                backgroundColor: UIColor(named: "mikadoYellow") ?? .yellow,
                titleColor: .black
            )
        }
    
    
    var body: some View {
            ZStack {
                Color("mikadoYellow")
                    .edgesIgnoringSafeArea(.all)
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(movieViewModel.movies) { movie in
                            NavigationLink(destination: DetailsView(isPresented: $isPresented, movie: movie)) {
                                VStack {
                                    AsyncImage(url: movie.posterPathImage) { phase in
                                        switch phase {
                                        case .empty:
                                            Image("defaultImage")
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
                                            Image("defaultImage")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .frame(width: 140, height: 240)
                                                .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                        @unknown default:
                                            Image("defaultImage")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .frame(width: 140, height: 240)
                                                .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                                        }
                                    }
                                    
                                    Text(movie.title ?? "Untitled")
                                        .font(.custom("Raleway", size: 15))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .frame(maxWidth: 140)
                                        .multilineTextAlignment(.center)
                                }
                                .onAppear {
                                    movieViewModel.loadMoreMoviesIfNeeded(currentMovie: movie, movies: movieViewModel.movies) {
                                        movieViewModel.getNowPlaying(page: movieViewModel.currentPage + 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .tint(.black)
       
    }
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingView(isPresented: .constant(false), title: "Now Playing")
    }
}
