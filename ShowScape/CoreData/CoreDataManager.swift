//
//  CoreDataManager.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/04/2025.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "FavoritesModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Erreur Core Data : \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }

    // 🔽 Ajout
    func addFavorite(movie: Result) {
        let favorite = Favorite(context: context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.overview = movie.overview
        favorite.posterpath = movie.posterPath
        saveContext()
    }

    // 🔽 Suppression
    func removeFavorite(id: Int) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))

        if let favorites = try? context.fetch(fetchRequest) {
            for favorite in favorites {
                context.delete(favorite)
            }
            saveContext()
        }
    }

    // 🔽 Vérification
    func isFavorite(id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        let count = (try? context.count(for: fetchRequest)) ?? 0
        return count > 0
    }

    // 🔽 Récupération
    func fetchFavorites() -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        return (try? context.fetch(fetchRequest)) ?? []
    }
}

