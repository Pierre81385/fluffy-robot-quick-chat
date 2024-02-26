//
//  NeumorphicStyle.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/13/24.
//

import SwiftUI

struct NeumorphicButton<S: Shape>: ButtonStyle {
    var shape: S
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(15)
            .background(Background(isPressed: configuration.isPressed, shape: shape))
    }
}
struct Background<S: Shape>: View {
    var isPressed: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isPressed {
                shape
                    .fill(Color.offWhite)
                    .overlay(
                        shape
                            .stroke(Color.gray, lineWidth: 3)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(shape.fill(LinearGradient(Color.black.opacity(0.8), Color.clear)))
                    )
                    .overlay(
                        shape
                            .stroke(Color.white, lineWidth: 3)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(shape.fill(LinearGradient(Color.clear, Color.black.opacity(0.8))))
                    )
            } else {
                shape
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.8), radius: 10, x: -5, y: -5)
            }
        }
    }
}
