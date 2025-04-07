//
//  SideMenuView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 07/01/2025.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Menu")
                .font(.custom("Raleway", size: 16))
                .foregroundColor(.black)
                .bold()
                .padding(.top, 100)


            // Favorites Button (prend toute la largeur)
            NavigationLink(destination: FavoritesView()) {
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
                    .background(Color.white)
                    .cornerRadius(25)
                    
            }
            .padding(.horizontal, 10)

            Spacer()
        }
        .frame(maxWidth: 250) // Largeur fixe du menu latéral
        .background(Color.mikadoYellow)
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    SideMenuView()
}
