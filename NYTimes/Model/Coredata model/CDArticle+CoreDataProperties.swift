//
//  CDArticle+CoreDataProperties.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//
//

import Foundation
import CoreData


extension CDArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticle> {
        return NSFetchRequest<CDArticle>(entityName: "CDArticle")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var subtitle: String
    @NSManaged public var author: String
    @NSManaged public var index: Int16
    @NSManaged public var url: String
    @NSManaged public var imageUrl: String

    public func set(from article: Article){
        self.id = article.id
        self.author = article.author
        self.title = article.title
        self.subtitle = article.subtitle
        self.url = article.url
        self.imageUrl = article.imageUrl
    }
    
}
