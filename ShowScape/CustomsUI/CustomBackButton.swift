//
//  CustomUI.swift
//  ShowScape
//
//  Created by Richard Arif Mazid on 27/05/2024.
//

import Foundation
import SwiftUI

struct CustomBackButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                    .font(.custom("Raleway", size: 20))
                    .bold()
                    .shadow(color: .white, radius: 0, x: 3, y: 2)
                Text("Back")
                    .foregroundColor(.black)
                    .font(.custom("Raleway", size: 20))
                    .bold()
                    .shadow(color: .white, radius: 0, x: 3, y: 2)
            }
        }
    }
}
