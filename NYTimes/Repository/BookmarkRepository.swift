//
//  BookmarkRepository.swift
//  NYTimes
//
//  Created by Waseem Akram on 31/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation
import CoreData


class BookmarkRepository {

    var context:NSManagedObjectContext!
    
    init(context:NSManagedObjectContext = PersistenceManager.shared.context){
        self.context = context
    }
    
    deinit {
        context = nil
    }
    
    func getAll() -> [CDArticle]? {
        guard let context = self.context else {return nil}
        let results:[CDArticle]? = try? context.fetch(CDArticle.fetchRequest())
        return results
    }
    
    func get(using URL:String)->CDArticle? {
        guard let context = self.context else {return nil}
        let fetchRequest:NSFetchRequest<CDArticle> = CDArticle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", URL)
        let results = try? context.fetch(fetchRequest)
        return results?.first
    }
    
    func isArticleExists(with URL:String) -> Bool {
        guard let context = self.context else {return false}
        do {
            let fetchRequest:NSFetchRequest<CDArticle> = CDArticle.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "url == %@", URL)
            let results = try context.fetch(fetchRequest)
            if results.first != nil {
                return true
            }
        }catch let error {
            debugPrint(error)
        }
        return false
    }
    
    func insert(article:Article,completion:((Bool)->Void)? = nil) {
        guard let context = self.context else {
            completion?(false)
            return
        }
        let cdArticle = CDArticle(context: context)
        cdArticle.set(from: article)
        insert(article: cdArticle) { (result) in
            completion?(result)
        }
    }
    
    func insert(article: CDArticle, completion:((Bool)->Void)? = nil) {
        guard let context = self.context else {
            completion?(false)
            return
        }
        
        do {
            if context.hasChanges {
                try context.save()
                completion?(true)
                return
            }
        }catch let error {
            debugPrint(error)
        }
        
        completion?(false)
    }

    func update(article: CDArticle,completion:((Bool)->Void)? = nil) {
        guard let context = self.context else {
            completion?(false)
            return
        }
        
        do {
            if context.hasChanges {
                try context.save()
                completion?(true)
                return
            }
        }catch let error {
            debugPrint(error)
        }
        
        completion?(false)
    }

    func delete(article: Article,completion: ((Bool)->Void)? = nil) {
        guard let context = self.context else {
            completion?(false)
            return
        }
        
        do {
            if let article = get(using: article.url) {
                context.delete(article)
                try context.save()
                completion?(true)
                return
            }
        }catch let error {
            debugPrint(error)
        }
        
        completion?(false)
    }
    
    func delete(article: CDArticle,completion: ((Bool)->Void)? = nil) {
        guard let context = self.context else {
            completion?(false)
            return
        }
        
        do {
            context.delete(article)
            try context.save()
            completion?(true)
            return
        }catch let error {
            debugPrint(error)
        }
        
        completion?(false)
    }

    func deleteAll() {
        guard let context = self.context else {return}
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: CDArticle.fetchRequest())
            try context.execute(deleteRequest)
            try context.save()
        }catch let error {
         debugPrint(error)
        }
    }

}
