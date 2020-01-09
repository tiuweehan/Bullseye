//
//  ContentView.swift
//  Bullseye
//
//  Created by Wee Han Tiu on 13/12/19.
//  Copyright © 2019 Tiu Wee Han. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static let DEFAULT_SLIDER_VALUE = 50.0
    static let DEFAULT_STARTING_SCORE = 0
    
    @State var alertIsVisible = false
    @State var sliderValue = DEFAULT_SLIDER_VALUE
    @State var target = Int.random(in: 1...100)
    @State var round = 1
    @State var totalScore = DEFAULT_STARTING_SCORE
    
    var roundedValue: Int {
        Int(sliderValue.rounded())
    }
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(.white)
                .modifier(ShadowStyle())
                .font(.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(.yellow)
                .modifier(ShadowStyle())
                .font(.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    var body: some View {
        VStack {
            
            Spacer()
            
            // Target row
            HStack {
                Text("Put the Bull's eye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(.green)
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in

                return Alert(
                    title: Text("Hello there!"),
                    message: Text(
                        "The slider's value is \(roundedValue).\n" +
                        "You scored \(pointsForCurrentRound()) points this round."
                    ),
                    dismissButton: .default(
                        Text("Awesome"),
                        action: {
                            self.nextRound()
                        }
                    )
                )
            }
            .background(Image("Button")).modifier(ShadowStyle())
            
            Spacer()
            
            // Score row
            HStack {
                
                Button(action: {
                    self.resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(ShadowStyle())
                
                Spacer()
                
                Text("Score:").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                
                Spacer()
                
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                
                Spacer()
                
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(ShadowStyle())

            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    // Score methods
    func pointsForCurrentRound() -> Int {
        100 - abs(roundedValue - target)
    }
    
    // Total score methods
    func addToTotalScore(_ value: Int) -> Void {
        totalScore += value
    }
    
    func resetTotalScore() -> Void {
        totalScore = 0
    }
    
    // Slider methods
    func resetSliderValue() -> Void {
        sliderValue = 50.0
    }
    
    // Target methods
    func generateNewTargetValue() -> Void {
        target = Int.random(in: 1...100)
    }
    
    // Round number methods
    func incrementRoundNumber() -> Void {
        round += 1
    }
    
    func resetRoundNumber() -> Void {
        round = 1
    }
    
    func nextRound() -> Void {
        incrementRoundNumber()
        addToTotalScore(pointsForCurrentRound())
        generateNewTargetValue()
    }
    
    func resetGame() -> Void {
        resetRoundNumber()
        resetTotalScore()
        resetSliderValue()
        generateNewTargetValue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
