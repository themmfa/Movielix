//
//  SplashScreenView.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 15.10.2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            Movies()
        }
        else {
            VStack {
                VStack {
                    Image(systemName: "film")
                        .font(.system(size: 80))
                    Text("Movielix")
                        .modifier(CustomTextModifier())
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        self.size = 1
                        self.opacity = 1
                    }
                }
                .scaleEffect(size)
                .opacity(opacity)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
