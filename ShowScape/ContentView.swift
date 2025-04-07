import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isViewPresented = false
    @State private var showMenu: Bool = false
    
    @StateObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fond principal
                Color("mikadoYellow")
                    .edgesIgnoringSafeArea(.all)
                
                // Contenu principal
                VStack {
                    searchField
                    Spacer().frame(height: 20)
                    
                    ScrollView(.vertical) {
                        Spacer().frame(height: 20)
                        
                        if !searchText.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Résultats pour « \(searchText) »")
                                    .font(.headline)
                                    .padding(.leading, 10)
                                
                                MovieVerticalListView(movies: movieViewModel.searchResults) { movie in
                                    DetailsView(isPresented: $isViewPresented, movie: movie)
                                }
                            }
                            .padding(.bottom)
                        }
                        else {
                            // Now playing
                            CategoryHeaderView(title: "Now playing", destination: TrendingView(isPresented: $isViewPresented, title: "Now playing"))
                            Spacer().frame(height: 10)
                            MovieScrollView(movies: movieViewModel.movies) { movie in
                                DetailsView(isPresented: $isViewPresented, movie: movie)
                            }
                            
                            // Popular
                            CategoryHeaderView(title: "Popular", destination: PopularView(isPresented: $isViewPresented, title: "Popular"))
                            Spacer().frame(height: 10)
                            MovieScrollView(movies: movieViewModel.popular) { movie in
                                DetailsView(isPresented: $isViewPresented, movie: movie)
                            }
                            
                            // Upcoming
                            CategoryHeaderView(title: "Upcoming", destination: TrendingView(isPresented: $isViewPresented, title: "Upcoming"))
                            Spacer().frame(height: 10)
                            MovieScrollView(movies: movieViewModel.nowAiring) { movie in
                                DetailsView(isPresented: $isViewPresented, movie: movie)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "text.justify")
                        }
                        .foregroundColor(.black)
                        .font(.custom("Raleway", size: 16))
                        .shadow(color: .white, radius: 0, x: 2, y: 1)
                        .bold()
                    }
                }
                //                .overlay(
                //                        VStack {
                //                            Spacer()
                //                            Rectangle()
                //                                .frame(height: 1) // Épaisseur de la ligne
                //                                .foregroundColor(.red) // Couleur de la ligne
                //                        }
                //                            .edgesIgnoringSafeArea(.all)
                //                    )
                
                // Menu latéral
                HStack {
                    SideMenuView()
                        .offset(x: showMenu ? 0 : -250) // Animation de translation
                    Spacer()
                }
                .background(
                    Color.black.opacity(showMenu ? 0.7 : 0)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }
                )
            }
            .onChange(of: searchText) {
                movieViewModel.searchMovies(query: searchText)
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
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.leading, -40)
                .gesture(
                    TapGesture()
                        .onEnded({
                            print("tapgesture")
                        })
                )
                .shadow(color: .black, radius: 0, x: 0, y: 0)
        }
        .padding(.horizontal, 10)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
