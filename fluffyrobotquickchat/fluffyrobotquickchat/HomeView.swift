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

struct HomeView: View {
    
    @State var screenWidth: Double = 0.0;
    @State var screenHeight: Double = 0.0;
   
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Background(isPressed: false, shape: Circle()).frame(width: 250, height: 250)
                    GlowTile_Circular()
                }.padding()
                VStack {
                    HStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("1").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                            
                            
                        Button(action: {}, label: {
                            Text("2").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("3").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                    }
                    HStack {
                        Button(action: {}, label: {
                            Text("4").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: {}, label: {
                            Text("5").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("6").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                    }
                    HStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("7").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: {}, label: {
                            Text("8").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("9").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                    }
                    HStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("*").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: {}, label: {
                            Text("0").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("#").foregroundColor(.black).frame(width: 50)
                        }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 15)))
                        
                    }
                }.frame(width: 250)
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

struct GlowTile_Circular: View {
    
    @State var rotation: CGFloat = 0.0
        
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(.black))
                .shadow(color: .white.opacity(0.2), radius: 10)
            Circle()
                .frame(width: 300, height: 300)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(.white),.black.opacity(0.5),.black]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask(Circle()
                    .stroke(lineWidth: 5)
                    .frame(width: 205, height: 205)
                    
                )
        }.onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
        
    }
}

#Preview {
    HomeView()
}
