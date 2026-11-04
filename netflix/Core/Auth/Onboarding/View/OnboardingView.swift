//
//  OnboardingView.swift
//  netflix
//
//  Created by BunliSem on 5/11/26.
//


import SwiftUI

struct OnboardingView: View {
    var onGetStarted: () -> Void

    @State private var currentPage: Int = 0

    private let totalPages = 3

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 25) {
                // Header
                HStack {
                    NetflixLogo()

                    Spacer()

                    Button("SKIP") {
                        withAnimation {
                            currentPage = totalPages - 1
                        }
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                }
                .padding(.horizontal, 25)
                .padding(.top, 40)

                // Onboarding Pages
                TabView(selection: $currentPage) {
                    PageView(currentPage: $currentPage, page: 0) {
                        onboardingContent(
                            icon: "play.rectangle.fill",
                            title: "Unlimited Movies",
                            subtitle: "Watch thousands of movies and TV shows anytime, anywhere."
                        )
                    }
                    .tag(0)

                    PageView(currentPage: $currentPage, page: 1) {
                        onboardingContent(
                            icon: "tv.fill",
                            title: "Watch Everywhere",
                            subtitle: "Enjoy your favorite entertainment on your phone, tablet and TV."
                        )
                    }
                    .tag(1)

                    PageView(currentPage: $currentPage, page: 2) {
                        onboardingContent(
                            icon: "arrow.down.circle.fill",
                            title: "Download & Watch",
                            subtitle: "Download your favorite movies and watch them offline."
                        )
                    }
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                // Page Indicator
                IndicatorView(
                    currentIndex: currentPage,
                    page: totalPages
                )

                // Next / Get Started Button
                BtnNetflix(
                    title: currentPage == totalPages - 1
                    ? "GET STARTED"
                    : "NEXT"
                ) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if currentPage < totalPages - 1 {
                            currentPage += 1
                        } else {
                            onGetStarted()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding(.top, 15)
        }
    }

    // Content
    private func onboardingContent(
        icon: String,
        title: String,
        subtitle: String
    ) -> some View {
        VStack(spacing: 25) {
            Spacer()

            Image(systemName: icon)
                .font(.system(size: 90))
                .foregroundStyle(.red)

            Text(title)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.system(size: 16))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Spacer()
        }
    }
}

#Preview {
    OnboardingView(onGetStarted: {})
}
