//
//  ArticleDetailViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation
import UIKit

final class ArticleDetailViewModel: ObservableObject {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: article.published_at) else { return "" }
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }
    
    func openInSafari() {
        guard let url = URL(string: article.url) else { return }
        UIApplication.shared.open(url)
    }
}
