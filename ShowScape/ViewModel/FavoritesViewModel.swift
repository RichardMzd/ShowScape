//
//  FavoritesViewModel.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/04/2025.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        // CoreDataManager.shared.fetchFavorites() te retourne déjà un tableau de `Favorite`
        favorites = CoreDataManager.shared.fetchFavorites()
    }

    func toggleFavorite(for movie: Movie) {
        if isFavorite(movie) {
            CoreDataManager.shared.removeFavorite(id: Int64(movie.id))
        } else {
            CoreDataManager.shared.addFavorite(movie: movie)
        }
        loadFavorites()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        CoreDataManager.shared.isFavorite(id: Int64(movie.id))
    }

    func removeFavorite(_ favorite: Favorite) {
        CoreDataManager.shared.removeFavorite(id: favorite.id)
        loadFavorites()
    }

//    func removeFavorite(at offsets: IndexSet) {
//        for index in offsets {
//            let favorite = favorites[index]
//            removeFavorite(favorite)
//        }
//    }
    
    func removeFavorite(at offsets: IndexSet) {
            favorites.remove(atOffsets: offsets)
        }
}





