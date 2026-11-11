//
//  PageView.swift
//  netflix
//
//  Created by BunliSem on 6/11/26.
//

//



import SwiftUI

struct PageView<Content: View>: View {

    @Binding var currentPage: Int

    var page: Int
    var content: Content

    init(
        currentPage: Binding<Int>,
        page: Int,
        @ViewBuilder content: () -> Content
    ) {
        self._currentPage = currentPage
        self.page = page
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(currentPage == page ? 1.0 : 0.95)
            .animation(.easeInOut(duration: 0.3), value: currentPage)
    }
}

