//
//  NetflixSplashView.swift
//  netflix
//
//  Created by BunliSem on 4/11/26.
//



import SwiftUI

struct NetflixSplashView: View {

    @State private var isAnimating: Bool = false
    @State private var viewScale: CGFloat = 1.8

    let letters = Array("NETFLIX")

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            HStack(spacing: 2) {

                ForEach(Array(letters.enumerated()), id: \.offset) { index, letter in

                    Text(String(letter))
                        .font(.system(size: 60, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.80, green: 0.04, blue: 0.08),
                                    Color(red: 0.50, green: 0.00, blue: 0.02)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .opacity(isAnimating ? 1 : 0)
                        .scaleEffect(isAnimating ? 1 : 0.5)
                        .offset(y: isAnimating ? 0 : 5)
                        .animation(
                            .easeOut(duration: 0.5)
                                .delay(Double(index) * 0.3),
                            value: isAnimating
                        )
                }
            }
            .scaleEffect(viewScale)
            .animation(
                .easeInOut(duration: 1.0),
                value: viewScale
            )
        }
        .onAppear {
            isAnimating = true
            viewScale = 1.0
        }
    }
}

#Preview {
    NetflixSplashView()
}

