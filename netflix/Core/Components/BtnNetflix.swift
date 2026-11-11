//
//  BtnNetflix.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

//

import SwiftUI

struct BtnNetflix: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.89, green: 0.04, blue: 0.08))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
//
//#Preview {
//    BtnNetflix()
//}
