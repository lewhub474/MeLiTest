//
//  Articles.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

struct Article: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let summary: String
    let imageUrl: String
    let url: String
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary
        case imageUrl = "image_url"
        case url
        case publishedAt = "published_at"
    }
}
