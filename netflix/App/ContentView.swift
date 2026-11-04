//
//  ContentView.swift
//  netflix
//
//  Created by BunliSem on 4/11/26.
//


import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var showOnboarding = false
    @State private var showHome = false

    @State private var showShareSheet = false
    @State private var showSafariSheet = false

    private let netflixURL = URL(string: "https://www.netflix.com")!

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
                homeScreen
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
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [netflixURL])
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showSafariSheet) {
            SafariSheet(url: netflixURL)
                .ignoresSafeArea()
        }
    }

    private var homeScreen: some View {
        VStack(spacing: 25) {
            NetflixLogo()

            Text("Welcome to Netflix")
                .font(.title2.bold())
                .foregroundStyle(.white)

            BtnNetflix(title: "VIEW NETFLIX") {
                showSafariSheet = true
            }

            BtnNetflix(title: "SHARE NETFLIX") {
                showShareSheet = true
            }

            InformationLink(
                title: "Netflix Information",
                url: netflixURL
            )
        }
        .padding(25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

#Preview {
    ContentView()
}
