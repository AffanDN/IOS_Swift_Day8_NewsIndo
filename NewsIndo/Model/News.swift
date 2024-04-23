//
//  News.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import Foundation

struct News: Decodable {
    let messages: String
    let total: Int
    let data: [NewsArticle]
}

// MARK: - NewsArticle
struct NewsArticle: Codable, Identifiable {
    var id: String {
        link
    }
    let creator, title: String
    let link: String
    let author: String
    let categories: [String]
    let isoDate, description: String
    let image: Image
}

// MARK: - Image
struct Image: Codable {
    let small, medium, large, extraLarge: String
}
