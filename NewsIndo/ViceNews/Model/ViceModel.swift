//
//  ViceModel.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import Foundation

// MARK: - Welcome
struct ViceModel: Codable {
    let messages: String
    let total: Int
    let data: [ViceArticle]
}

// MARK: - Vice Article
struct ViceArticle: Codable, Identifiable {
    var id: String {
        link
    }
    let creator, title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: String
}
