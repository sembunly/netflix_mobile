//
//  ContentView.swift
//  netflix
//
//  Created by BunliSem on 4/11/26.
//


import SwiftUI

struct ContentView: View {

    @State private var showSplash: Bool = true

    var body: some View {

        ZStack {

            if showSplash {

                NetflixSplashView()
                    .transition(.opacity)

            } else {

                VStack {
                    Text("NETFLIX")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.red)

                    Text("Home Screen")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .transition(.opacity)
            }
        }
        .ignoresSafeArea()
        .onAppear {

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

                withAnimation(.easeInOut(duration: 1.2)) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

