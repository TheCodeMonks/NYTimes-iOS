//
//  BookmarksRepository.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation
import CoreData

 protocol BookmarksRepository {
        
    func upsert(article:Article) -> Bool
    func get(index:Int16) -> Bookmark?
    func getAll() -> [Bookmark]
    func delete(index:Int16) -> Bool
    func deleteAll() -> Bool
    func swapIndex(source:Int16,destination:Int16)
    func getBookmarksCount() -> Int
    func updateOtherBookmarksIndex(after:Int16)

}

class BookmarksDataRepository:BookmarksRepository {
    
     func upsert(article: Article) -> Bool {
        return true
    }
    
     func get(index: Int16) -> Bookmark? {
        let fetchRequest = NSFetchRequest<CDBookmarks>(entityName: "CDBookmarks")
        fetchRequest.predicate = NSPredicate(format: "index == %@", index as CVarArg)
        do {
            let result = try PersistenceManager.shared.context.fetch(fetchRequest).first
            if let result = result {
                return Bookmark(from: result)
            }
        }catch let error {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    
     func getAll() -> [Bookmark] {
        return [Bookmark]()
    }
    
    func delete(index: Int16) -> Bool {
        return true
    }
    
     func deleteAll() -> Bool {
        return true
    }
    
     func swapIndex(source: Int16, destination: Int16) {
        
    }
    
    func getBookmarksCount() -> Int {
        return 0 
    }
    
    func updateOtherBookmarksIndex(after:Int16){
    }
    
}
