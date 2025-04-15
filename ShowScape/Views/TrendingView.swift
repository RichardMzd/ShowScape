import SwiftUI

struct TrendingView: View {
    
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
        ZStack {
            Color("mikadoYellow")
                .edgesIgnoringSafeArea(.all)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)

            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(movieViewModel.movies) { movie in
                        NavigationLink(destination: DetailsView(isPresented: $isPresented, movie: movie, isFromFavorites: false)) {
                            MovieCardView(movie: movie) {
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
