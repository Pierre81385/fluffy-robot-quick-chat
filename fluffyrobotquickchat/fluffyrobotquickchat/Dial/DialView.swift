//
//  SwiftUIView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//
//  The view to show your current status (online, offline) and availible chat rooms
//  Also show links to create a new room or enter a room code to join a private room
//  List out users online

import SwiftUI

struct DialView: View {
    
    @State var screenWidth: Double = 0.0;
    @State var screenHeight: Double = 0.0;
    @State var dialValue: CGFloat = 0.0;
    @State var val1: CGFloat = 0.0;
    @State var val2: CGFloat = 0.0;
    @State var val3: CGFloat = 0.0;
    @State var unlock: Bool = false;
    @State var unlockSuccess: Bool = false;
    @State var statusColor: Color = .gray.opacity(0.8)

   
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    if (val1 == 0.0) {Text("").NeumorphicStyle()} else {Text("\(val1, specifier: "%.0f")").NeumorphicStyle()}
                    if (val2 == 0.0) {Text("").NeumorphicStyle()} else {Text("\(val2, specifier: "%.0f")").NeumorphicStyle()}
                    if (val3 == 0.0) {Text("").NeumorphicStyle()} else {Text("\(val3, specifier: "%.0f")").NeumorphicStyle()}
                }
                Spacer()
                Text("Rotate the dial to enter your room code.")
                ZStack {
                    Background(isPressed: false, shape: Circle()).frame(width: 300, height: 300)
                    GlowTile_Circular(ringColor: statusColor)
                    Dial(dialValue: $dialValue)
                }.padding()
                Spacer()
                Button(action: {
                    if (val1 == 0.0) {
                        val1 = dialValue.rounded()
                        
                    } else if (val2 == 0.0) {
                        val2 = dialValue.rounded()
                        
                    } else if (val3 == 0.0) {
                        val3 = dialValue.rounded()
                        unlock = true
                        statusColor = .orange.opacity(0.8)
                    } else {
                        if (val1 == 14 && val2 == 89 && val3 == 28){
                            unlockSuccess = true
                            statusColor = .green.opacity(0.8)
                            val1 = 0
                            val2 = 0
                            val3 = 0
                        } else {
                            statusColor = .red.opacity(0.8)
                            unlockSuccess = false
                            val1 = 0
                            val2 = 0
                            val3 = 0
                            unlock = false
                        }
                    }
                }, label: {
                    if (unlock) {Text("Unlock").foregroundColor(.green).frame(width: 100)} else { Text("Set").frame(width: 100)}
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                    .padding()
                Spacer()
                
//
            }
        }
        .onAppear {
            screenWidth = UIScreen.main.bounds.size.width
            screenHeight = UIScreen.main.bounds.size.height
        }
        .NeumorphicStyle()
        .ignoresSafeArea()
    }
}

#Preview {
    DialView()
}
