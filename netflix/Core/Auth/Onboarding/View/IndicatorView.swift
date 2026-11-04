//
//  IndicatorView.swift
//  netflix
//
//  Created by BunliSem on 5/11/26.
//


import SwiftUI

struct IndicatorView: View {

    var currentIndex: Int
    var page: Int

    var body: some View {

        HStack(spacing: 8) {

            ForEach(0..<page, id: \.self) { index in

                Capsule()
                    .fill(
                        currentIndex == index
                        ? Color.red
                        : Color.gray.opacity(0.5)
                    )
                    .frame(
                        width: currentIndex == index ? 24 : 8,
                        height: 8
                    )
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: currentIndex
                    )
            }
        }
    }
}

//
//#Preview {
//    IndicatorView()
//}
