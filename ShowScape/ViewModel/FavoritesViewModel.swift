//
//  FavoritesViewModel.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/04/2025.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []

    init() {
        loadFavorites()
    }

    // 🔁 Recharge les favoris depuis Core Data
    func loadFavorites() {
        favorites = CoreDataManager.shared.fetchFavorites()
    }

    // ✅ Ajoute ou retire des favoris
    func toggleFavorite(for movie: Result) {
        if isFavorite(movie) {
            CoreDataManager.shared.removeFavorite(id: movie.id)
        } else {
            CoreDataManager.shared.addFavorite(movie: movie)
        }
        loadFavorites()
    }

    // 🔍 Vérifie si un film est en favori
    func isFavorite(_ movie: Result) -> Bool {
        CoreDataManager.shared.isFavorite(id: movie.id)
    }
}
