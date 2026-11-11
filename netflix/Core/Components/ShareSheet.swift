//
//  ShareSheet.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
    }

    func updateUIViewController(
        _ controller: UIActivityViewController,
        context: Context
    ) {}
}

//#Preview {
//    ShareSheet()
//}
