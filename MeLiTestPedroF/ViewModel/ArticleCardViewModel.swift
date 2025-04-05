//
//  ArticleCardViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class ArticleCardViewModel: ObservableObject {
    let article: Article

    init(article: Article) {
        self.article = article
    }

    var imageURL: URL? {
        URL(string: article.image_url)
    }

    var title: String {
        article.title
    }

    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: article.published_at) else { return "" }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }

    var summary: String {
        article.summary
    }
}
