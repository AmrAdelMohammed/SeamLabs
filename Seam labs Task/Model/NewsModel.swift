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
    var publishedAt: String?
    var content: String?
    
    init(sourceID: String? = nil, sourceNAme: String? = nil, author: String? = nil, title: String? = nil, description: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.source = Source(id: sourceID, name: sourceNAme)
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String?
    
    init(id: String? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
}
