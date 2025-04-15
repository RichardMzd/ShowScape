//
//  NewView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 20/05/2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesVM: FavoritesViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("mikadoYellow")
                    .ignoresSafeArea()
                
                if favoritesVM.favorites.isEmpty {
                    Text("No favorites")
                        .font(.headline)
                        .foregroundColor(.black)
                } else {
                    List {
                        ForEach(favoritesVM.favorites.indices, id: \.self) { index in
                            ZStack {
                                // NavigationLink invisible
                                NavigationLink(destination: DetailsView(
                                    isPresented: .constant(true),
                                    movie: favoritesVM.favorites[index].asMovie, isFromFavorites: true
                                )
                                .environmentObject(favoritesVM)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                // Votre vue personnalisée sans le chevron natif
                                FavoriteRow(favorite: $favoritesVM.favorites[index])
                                    .padding()
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(12)
                                    .contentShape(Rectangle()) // Pour garantir que toute la cellule est tappable
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color("mikadoYellow"))
                            .swipeActions(edge: .trailing) {
                                Button {
                                    // Utilisation de removeFavorite avec un IndexSet
                                    favoritesVM.removeFavorite(at: IndexSet([index]))
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                                
                                Button(role: .cancel) {
                                    // Action pour annuler (rien faire)
                                } label: {
                                    Label("Cancel", systemImage: "xmark")
                                }
                                .tint(.gray)
                            }
                        }
                    }
                    .listStyle(.plain)

                }
            }
            .navigationTitle("Favorites")
        }
    }
}

























