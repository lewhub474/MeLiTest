//
//  ArticleDetailViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class ArticleDetailViewModel: ObservableObject {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: article.publishedAt) else { return "" }
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }
}
