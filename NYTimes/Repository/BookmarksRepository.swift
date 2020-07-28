//
//  BookmarksRepository.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation


class BookmarksRepository:Repository {
    
    typealias T = Bookmark
    
    func upsert(data: Bookmark) -> Bool {
        return true
    }
    
    func get(id: UUID) -> Bookmark {
        return Bookmark(id: UUID(), url: "", title: "", subtitle: "", author: "", index: 0)
    }
    
    func getAll() -> [Bookmark] {
        return [Bookmark]()
    }
    
    func delete(id: UUID) -> Bool {
        return true
    }
    
    func deleteAll() -> Bool {
        return true
    }
    
}
