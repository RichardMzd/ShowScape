//
//  CategoryHeaderView.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 22/08/2024.
//

import SwiftUI

struct CategoryHeaderView<Destination: View>: View {
    var title: String
    var destination: Destination
    
    var body: some View {
        ZStack {
            Color("mikadoYellow")
                .edgesIgnoringSafeArea(.all)
            NavigationLink(destination: destination) {
                HStack {
                    Text(title)
                        .font(.custom("Raleway-Bold", size: 20))
                        .shadow(color: .white, radius: 0, x: 3, y: 2)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .shadow(color: .white, radius: 0, x: 3, y: 2)
                }
                .padding(10)
                .background(Color.white.opacity(1.0))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.5), radius: 0, x: 5, y: 5)
                

            }
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.black, lineWidth: 2)
            )
            // Aligner à gauche avec un padding
            .frame(maxWidth: .infinity, alignment: .leading) // Étend l'espace disponible pour aligner à gauche
            .padding(.leading, 15) // Ajuste l'espacement depuis le bord gauche
        }
    }

}

#Preview {
    CategoryHeaderView(
        title: "Sample Title",
        destination: Text("Sample Destination View")
    )
}

