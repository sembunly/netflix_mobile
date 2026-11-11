//
//  InformationLink.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

//

import SwiftUI

struct InformationLink: View {
    let title: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .underline()
        }
    }
}
//
//#Preview {
//    InformationLink()
//}
