//
//  NewEntities+CoreDataClass.swift
//  Seam labs Task
//
//  Created by Amr Adel on 05/09/2023.
//

import CoreData

@objc(NewsEntites)
class NewsEntites: NSManagedObject {

    static func create(dbManager: DataBaseManager,
                       author: String,
                       news_description: String,
                       title: String,
                       url: String,
                       urlToImage: String,
                       publishedAt: String,
                       content: String,
                       source_id: String,
                       source_name: String) -> NewsEntites {
        guard let dbManager = dbManager as? CoreDataStackManager else {
            fatalError("dbManager must be a CoreDataStackManager")
        }
        var entity: NewsEntites!
        dbManager.backgroundContext.performAndWait {
            entity = NewsEntites(entity: NewsEntites.entity(),
                                   insertInto: dbManager.backgroundContext)
            entity.author = author
            entity.news_description = news_description
            entity.title = title
            entity.url = url
            entity.urlToImage = urlToImage
            entity.publishedAt = publishedAt
            entity.content = content
            entity.source_id = source_id
            entity.source_name = source_name
            
        }
        return entity
    }
}
