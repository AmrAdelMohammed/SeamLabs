//
//  HomeLocalDataSource.swift
//  Seam labs Task
//
//  Created by Amr Adel on 05/09/2023.
//

import Foundation

protocol HomeLocalDataSource {
    func getNews() -> [Article]
    func saveArticles(_ articles: [Article])
    func deleteAllArticles()
}


class AppHomeLocalDataSource: HomeLocalDataSource {
    
    private let dataBaseManager: DataBaseManager
    private let decodingService: DecodingService
    
    init(dataBaseManager: DataBaseManager = CoreDataStackManager(),
         decodingService: DecodingService = AppDecodingService()) {
        self.dataBaseManager = dataBaseManager
        self.decodingService = decodingService
    }
    
    func getNews() -> [Article] {
        do {
            let news = try self.dataBaseManager.fetch(query: NewsEntites.fetchRequest(),
                                                      output: NewsEntites.self)
            return news.map {
                Article(sourceID: $0.source_id, sourceNAme: $0.source_name, author: $0.author, title: $0.title, description: $0.news_description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)
            }
        } catch {
            return []
        }
    }
    
    func saveArticles(_ articles: [Article]) {
        let newArticles = articles.map {
            return NewsEntites.create(dbManager: dataBaseManager, author: $0.author ?? "", news_description: $0.description ?? "", title: $0.title ?? "", url: $0.url ?? "", urlToImage: $0.urlToImage ?? "", publishedAt: $0.publishedAt ?? "", content: $0.content ?? "", source_id: $0.source?.id ?? "", source_name: $0.source?.name ?? "")
                                       
        }
        self.dataBaseManager.insert(data: newArticles,
                                    entity: "NewsEntites")
    }
    
    func deleteAllArticles() {
        self.dataBaseManager.deleteAll(entityName: "NewsEntites")
    }
}
