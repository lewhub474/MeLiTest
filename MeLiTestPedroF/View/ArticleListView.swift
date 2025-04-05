//
//  ArticleListView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        ArticleCard(article: article)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                }
            }
            .padding(.top)
        }
    }
}
