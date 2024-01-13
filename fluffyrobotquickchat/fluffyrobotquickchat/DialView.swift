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
   
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    Background(isPressed: false, shape: Circle()).frame(width: 300, height: 300)
                    GlowTile_Circular()
                    Dial(temperature: 0)
                }.padding()
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

struct GlowTile_Circular: View {
    
    @State var rotation: CGFloat = 0.0
        
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 270, height: 270)
                .foregroundColor(Color(.black))
                .shadow(color: .white.opacity(0.2), radius: 10)
            Circle()
                .frame(width: 270, height: 270)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(.white),.black.opacity(0.5),.black]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask(Circle()
                    .stroke(lineWidth: 15)
                    .frame(width: 275, height: 275)
                    
                )
        }.onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
        
    }
}

struct Dial: View {
    
    private let initialTemperature: CGFloat
    private let scale: CGFloat = 290
    private let indicatorLength: CGFloat = 5
    private let maxTemperature: CGFloat = 100
    private let stepSize: CGFloat = 0.5
    
    @State private var value: CGFloat = 0
    
    private var innerScale: CGFloat {
        return scale - indicatorLength
    }
    
    init(temperature: CGFloat) {
        self.initialTemperature = temperature
    }
    
    private func angle(between starting: CGPoint, ending: CGPoint) -> CGFloat {
        let center = CGPoint(x: ending.x - starting.x, y: ending.y - starting.y)
        let radians = atan2(center.y, center.x)
        var degrees = 90 + (radians * 180 / .pi)

        if degrees < 0 {
            degrees += 360
        }

        return degrees
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(.white.opacity(0.2))
                .frame(width: self.innerScale, height: self.innerScale, alignment: .center)
                .rotationEffect(.degrees(-90))
                .gesture(
                DragGesture().onChanged() { value in
                let x: CGFloat = min(max(value.location.x, 0), self.innerScale)
                let y: CGFloat = min(max(value.location.y, 0), self.innerScale)
                let ending = CGPoint(x: x, y: y)
                let start = CGPoint(x: (self.innerScale) / 2, y: (self.innerScale) / 2)
                let angle = self.angle(between: start, ending: ending)
                self.value = CGFloat(Int(((angle / 360) * (self.maxTemperature / self.stepSize)))) / (self.maxTemperature / self.stepSize)
                                    }
                                )
//            Circle()
//                .stroke(.gray.opacity(0.1), style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
//                .frame(width: self.scale, height: self.scale, alignment: .center)
            Circle()
                .trim(from: 0.0, to: self.value)
                .stroke(.white, style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .rotationEffect(.degrees(-90))
                .frame(width: 250, height: 250, alignment: .center)
            
            Text("\(self.value * self.maxTemperature, specifier: "%.0f")")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
        .onAppear(perform: {
            self.value = self.initialTemperature / self.maxTemperature
        })
    }
}

#Preview {
    DialView()
}
