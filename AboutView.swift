//
//  AboutView.swift
//  Bullseye
//
//  Created by Wee Han Tiu on 14/12/19.
//  Copyright © 2019 Tiu Wee Han. All rights reserved.
//

import SwiftUI

struct AboutHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 30))
            .padding(.vertical, 20)
    }
}

struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 60)
            .padding(.bottom, 20)
    }
}

struct AboutView: View {
    
    let peachPuff = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)

    var body: some View {
        Group {
            VStack {

                Text("🎯 Bullseye 🎯").modifier(AboutHeaderStyle())

                
                Text("This is Bullseye, the game where you can earn points and win fame by dragging a slider.").modifier(AboutBodyStyle())

                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(AboutBodyStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(peachPuff)
            .multilineTextAlignment(.center)
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
