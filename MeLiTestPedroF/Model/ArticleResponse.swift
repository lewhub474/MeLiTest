//
//  ArticleResponse.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

struct ArticleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Article]
}
