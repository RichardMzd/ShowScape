//
//  SideMenuView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/01/2025.
//

import SwiftUI

struct SideMenuView: View {
    @Environment(\.presentationMode) var presentationMode // Pour fermer le menu lorsqu'on clique sur un bouton
    @Binding var isFavoritesViewPresented: Bool // Variable pour afficher ou non la vue des favoris
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Menu")
                .font(.custom("Raleway", size: 16))
                .foregroundColor(.black)
                .bold()
                .padding(.top, 100)
            
            // Favorites Button (prend toute la largeur)
            Button(action: {
                // Afficher la vue des favoris
                isFavoritesViewPresented = true
                presentationMode.wrappedValue.dismiss() // Fermer le menu latéral
            }) {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("Favorites")
                        .foregroundColor(.black)
                        .font(.custom("Raleway", size: 16))
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity) // Prend toute la largeur
                .background(Color.white.opacity(0.5))
                .cornerRadius(25)
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
        .frame(maxWidth: 250) // Largeur fixe du menu latéral
        .background(Color("mikadoYellow"))
        .edgesIgnoringSafeArea(.all)
    }
}




struct SideMenuView_Previews: PreviewProvider {
    @State static var isFavoritesViewPresented = false

    static var previews: some View {
        SideMenuView(isFavoritesViewPresented: $isFavoritesViewPresented)
            .previewLayout(.sizeThatFits)
            .frame(width: 250)
            .background(Color("mikadoYellow")) // Ajouter un fond de couleur pour simuler l'écran
    }
}
