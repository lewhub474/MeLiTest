//
//  Articles.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

struct ArticleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Article]
}

struct Article: Identifiable, Codable {
    let id: Int
    let title: String
    let summary: String
    let image_url: String
    let url: String
    let published_at: String
}
