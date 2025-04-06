//
//  Articles.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

struct Article: Identifiable, Codable {
    let id: Int
    let title: String
    let summary: String
    let image_url: String
    let url: String
    let published_at: String
}
