//
//  ViewExtension.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI

extension View {
    func NeumorphicStyle() -> some View {
        self.padding(30)
            .frame(maxWidth: .infinity)
            .background(Color.offWhite)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

extension View {
    func NeumorphicPressedStyle() -> some View {
        self.padding(30)
            .frame(maxWidth: .infinity)
            .background(Color.offWhite)
            .cornerRadius(20)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
    }
}
