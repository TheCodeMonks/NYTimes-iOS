//
//  CDBookmarks+CoreDataProperties.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//
//

import Foundation
import CoreData


extension CDBookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBookmarks> {
        return NSFetchRequest<CDBookmarks>(entityName: "CDBookmarks")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var index: Int16
    @NSManaged public var article: Article?

}
