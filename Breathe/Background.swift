//
//  background.swift
//  Breathe
//
//  Created by Ian M. on 2024-05-28.
//

import Foundation
import SwiftUI


//styles button D for Default
struct DButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(Color.notWhite)
            .foregroundColor(.notBlack)
            .font(Font.custom("Quicksand-Bold", size: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.notBlack, lineWidth: 8)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

//MButton M for menu
struct MButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.notWhite)
            .foregroundColor(.notBlack)
            .font(Font.custom("Quicksand-Bold", size: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.notBlack, lineWidth: 5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}

// custom text box
struct DTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(20)
            .background(.notWhite)
            .cornerRadius(20)
            //.shadow(color: .notBlack, radius: 05)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.notBlack, lineWidth: 2))
            .fixedSize()
            .font(Font.custom("Quicksand-Bold",size:16))
    }
}



// Define a struct that represents a single animated circle
struct AnimatedCircle: View {
    let size: CGFloat
    let color: Color
    @State private var isAnimating = false
    
// animation controls
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .scaleEffect(isAnimating ? 2 : 1)
            .blur(radius: isAnimating ? 80 : 40)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 20).repeatForever(autoreverses: true)) {
                    isAnimating.toggle()
                }
            }
    }
}

// Define the main background view that uses animated circles
struct BackgroundCirclesView: View {
    // Use  custom colors by their names as defined in asset catalog
    let colors: [Color] = [.uduGreen, .canduBlue, .woohooRed, .perfectPink, .ohOrange, .pleasePurple] // more colors = more circles.
    let sizes: [CGFloat] = [ 200, 300, 400, 500]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.notWhite
                .ignoresSafeArea()
                ForEach(0..<colors.count, id: \.self) { index in
                    AnimatedCircle(size: sizes[index % sizes.count], color: colors[index % colors.count])
                        .position(x: CGFloat.random(in: 0...geometry.size.width),
                                  y: CGFloat.random(in: 0...geometry.size.height))
                }
            }
            .drawingGroup() // This modifier helps with performance when applying blur effects, I don't know why.
        }
        .edgesIgnoringSafeArea(.all) // Ensure the background extends to the edges of the display
    }
}



/* Usage example in ContentView or any other view
 struct ContentView: View {
 var body: some View {
 ZStack {
 BackgroundCirclesView()
 //  other content here
 }
 }
 }
 */
