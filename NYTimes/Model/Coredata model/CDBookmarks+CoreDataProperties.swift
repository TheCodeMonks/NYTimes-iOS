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
    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var author: String?
    @NSManaged public var index: Int16

}
