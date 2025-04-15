//
//  ShowScapeApp.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 24/04/2024.
//

import SwiftUI

@main
struct ShowScapeApp: App {
    @StateObject private var favoritesVM = FavoritesViewModel() // Instance partagée

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesVM) // Injection de l'instance globale
        }
    }
}

