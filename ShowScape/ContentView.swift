import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isViewPresented = false
    @State private var showMenu: Bool = false
    @State private var isFavoritesViewPresented: Bool = false

    @StateObject var movieViewModel = MovieViewModel()
    @EnvironmentObject var favoritesVM: FavoritesViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("mikadoYellow")
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    searchField
                    Spacer().frame(height: 20)

                    ScrollView(.vertical) {
                        Spacer().frame(height: 20)

                        if !searchText.isEmpty {
                            searchResultsSection
                        } else {
                            nowPlayingSection
                            popularSection
                            upcomingSection
                        }
                    }

                    Spacer()
                }
                .padding(.top)
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "text.justify")
                        }
                        .foregroundColor(.black)
                        .font(.custom("Raleway", size: 16))
                        .bold()
                    }
                }

                Color.black
                    .opacity(showMenu ? 0.7 : 0)
                    .animation(.easeInOut(duration: 0.3), value: showMenu)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showMenu = false
                        }
                    }

                SideMenuView(isFavoritesViewPresented: $isFavoritesViewPresented)
                    .frame(width: 250)
                    .offset(x: showMenu ? -100 : -350)
                    .animation(.easeInOut(duration: 0.3).delay(0.1), value: showMenu)
            }
            .onChange(of: searchText) {
                movieViewModel.searchMovies(query: searchText)
            }
            .navigationDestination(isPresented: $isFavoritesViewPresented) {
                FavoritesView()
            }
        }
        .tint(.black)
    }

    private var searchField: some View {
        HStack {
            TextField("Find movies, series...", text: $searchText)
                .padding(15)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black, lineWidth: 4)
                )
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)

            if searchText.isEmpty {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .padding(.leading, -40)
                    .shadow(color: .black, radius: 0, x: 0, y: 0)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.black)
                    .padding(.leading, -40)
                    .onTapGesture {
                        searchText = ""
                    }
                    .shadow(color: .black, radius: 0, x: 0, y: 0)
            }
        }
        .padding(.horizontal, 10)
    }

    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Résultats pour « \(searchText) »")
                .font(.headline)
                .padding(.leading, 10)

            MovieVerticalListView(movies: movieViewModel.searchResults) { movie in
                DetailsView(isPresented: $isViewPresented, movie: movie, isFromFavorites: false)
            }
        }
        .padding(.bottom)
    }

    private var nowPlayingSection: some View {
        VStack(spacing: 10) {
            CategoryHeaderView(title: "Now playing", destination: TrendingView(isPresented: $isViewPresented, title: "Now playing"))
            MovieScrollView(movies: movieViewModel.movies) { movie in
                DetailsView(isPresented: $isViewPresented, movie: movie, isFromFavorites: false)
            }
        }
    }

    private var popularSection: some View {
        VStack(spacing: 10) {
            CategoryHeaderView(title: "Popular", destination: PopularView(isPresented: $isViewPresented, title: "Popular"))
            MovieScrollView(movies: movieViewModel.popular) { movie in
                DetailsView(isPresented: $isViewPresented, movie: movie, isFromFavorites: false)
            }
        }
    }

    private var upcomingSection: some View {
        VStack(spacing: 10) {
            CategoryHeaderView(title: "Upcoming", destination: TrendingView(isPresented: $isViewPresented, title: "Upcoming"))
            MovieScrollView(movies: movieViewModel.nowAiring) { movie in
                DetailsView(isPresented: $isViewPresented, movie: movie, isFromFavorites: false)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FavoritesViewModel())
    }
}
