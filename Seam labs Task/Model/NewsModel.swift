//
//  NewsModel.swift
//  Seam labs Task
//
//  Created by Amr Adel on 04/09/2023.
//

import Foundation

struct NewsModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author: String?
    var title, description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String?
}
