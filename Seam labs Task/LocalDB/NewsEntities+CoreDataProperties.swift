//
//  NewsEntities+CoreDataProperties.swift
//  Seam labs Task
//
//  Created by Amr Adel on 05/09/2023.
//

import CoreData

extension NewsEntites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntites> {
        return NSFetchRequest<NewsEntites>(entityName: "NewsEntites")
    }

    @NSManaged public var source_id: String?
    @NSManaged public var source_name: String?
    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var news_description: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
}

extension NewsEntites : Identifiable {

}
