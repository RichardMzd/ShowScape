//
//  CoreDataManager.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/04/2025.
//

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
            do {
                try context.save()
            } catch {
                print("Erreur lors de la sauvegarde du contexte : \(error.localizedDescription)")
            }
        }
    }

    func addFavorite(movie: Movie) {
        let favorite = Favorite(context: context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.overview = movie.overview
        favorite.posterpath = movie.posterPath
        saveContext()
    }

    func removeFavorite(id: Int64) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))

        do {
            let favorites = try context.fetch(fetchRequest)
            for favorite in favorites {
                context.delete(favorite)
            }
            saveContext()
        } catch {
            print("Erreur lors de la suppression du favori : \(error.localizedDescription)")
        }
    }

    func isFavorite(id: Int64) -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Erreur lors de la vérification du favori : \(error.localizedDescription)")
            return false
        }
    }

    func fetchFavorites() -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            return try context.fetch(fetchRequest) // Retourne des objets `Favorite` directement
        } catch {
            return [] // En cas d'erreur, retourne un tableau vide
        }
    }

}


