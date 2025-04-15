//
//  Favorite.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 14/04/2025.
//

import Foundation

extension Favorite {
    var asMovie: Movie {
        return Movie(
            adult: nil, // Valeur par défaut, ou tu peux utiliser des valeurs concrètes si tu en as
            backdropPath: nil, // Valeur par défaut
            genreIDS: [], // Liste vide par défaut
            id: Int(self.id),
            originalLanguage: nil, // Si tu as cette info, tu peux la remplacer
            originalTitle: nil, // Pas d'originalTitle disponible, tu peux le laisser nil
            overview: self.overview ?? "",
            popularity: nil, // Valeur par défaut
            posterPath: self.posterpath,
            releaseDate: nil, // Pas de date de sortie
            title: self.title ?? "Untitled",
            video: nil, // Valeur par défaut
            voteAverage: nil, // Valeur par défaut
            voteCount: nil // Valeur par défaut
        )
    }
}

