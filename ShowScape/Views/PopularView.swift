//
//  PopularView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 20/05/2024.
//

import SwiftUI
import Combine

struct PopularView: View {
    
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss // Pour gérer le retour
    @StateObject var movieViewModel = MovieViewModel()
    
    var title: String // Ajout du titre comme paramètre
    
    
    var body: some View {
        ZStack {
            Color("mikadoYellow")
                .edgesIgnoringSafeArea(.all)
                .toolbar {
                    // Bouton "Back" personnalisé
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss() // Action pour revenir en arrière
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Home") // Texte du bouton
                            }
                            .padding(8)
                            .font(.custom("Raleway-Bold", size: 15))
                            .shadow(color: .white, radius: 0, x: 3, y: 2)
                            .foregroundColor(.black) // Couleur personnalisée
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            )
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                            
                        }
                    }
                    
                    // Titre personnalisé
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.custom("Raleway", size: 20))
                            .bold()
                            .shadow(color: .white, radius: 0, x: 3, y: 2)
                    }
                }
                .navigationBarBackButtonHidden(true) // Cache le bouton natif
                .navigationBarTitleDisplayMode(.inline)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(movieViewModel.popular) { movie in
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
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .frame(maxWidth: 140)
                                    .multilineTextAlignment(.center)
                            }
                            .onAppear {
                                movieViewModel.loadMoreMoviesIfNeeded(currentMovie: movie, movies: movieViewModel.popular) {
                                    movieViewModel.getPopularPosts(page: movieViewModel.currentPage + 1)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView(isPresented: .constant(false), title: "") // Provide a constant Binding for preview
    }
}

