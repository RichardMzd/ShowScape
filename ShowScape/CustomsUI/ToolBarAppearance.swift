//
//  ToolBarAppearance.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 25/12/2024.
//

import Foundation
import UIKit

struct ToolBarAppearance {
    static func configureNavigationBarAppearance(backgroundColor: UIColor, titleColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // Supprime la transparence
        appearance.backgroundColor = backgroundColor // Applique la couleur de fond
        appearance.titleTextAttributes = [.foregroundColor: titleColor] // Couleur du texte
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        appearance.shadowColor = .clear // Supprime le trait fin en bas

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
