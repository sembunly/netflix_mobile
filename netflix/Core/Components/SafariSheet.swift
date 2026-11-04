//
//  SafariSheet.swift
//  netflix
//
//  Created by BunliSem on 5/11/26.
//

import SwiftUI

import SafariServices

struct SafariSheet: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(
        _ controller: SFSafariViewController,
        context: Context
    ) {}
}

//#Preview {
//    SafariSheet()
//}
