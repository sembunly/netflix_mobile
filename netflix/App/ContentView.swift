//
//  ContentView.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//


import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var showOnboarding = false
    @State private var showHome = false

    var body: some View {
        ZStack {
            if showSplash {
                NetflixSplashView()
                    .transition(.opacity)

            } else if showOnboarding {
                OnboardingView {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showOnboarding = false
                        showHome = true
                    }
                }
                .transition(.opacity)

            } else if showHome {
                HomeView()
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showSplash = false
                    showOnboarding = true
                }
            }
        }
    }

}

#Preview {
    ContentView()
}
