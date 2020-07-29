//
//  PlaceholderBookmarkRepository.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

class PlaceholderBookmarksRepository:BookmarksRepository {
    
     let articles = [
        Article(
            url: "https://static01.nyt.com/images/2020/07/28/science/28SCI-MARS-JEZERO1/28SCI-MARS-JEZERO1-jumbo.jpg",
            title: "How NASA Found the Ideal Hole on Mars to Land In",
            subtitle: "Jezero crater, the destination of the Perseverance rover, is a promising place to look for evidence of extinct Martian life.",
            author: "KENNETH CHANG"
        ),
        Article(
            url: "https://static01.nyt.com/images/2020/07/28/science/28VIRGINGALACTIC2/28VIRGINGALACTIC2-videoLarge.jpg",
            title: "Virgin Galactic Unveils Comfy Cabin for Jet-Setting to the Edge of Space",
            subtitle: "Passengers able to pay hundreds of thousands of dollars for a seat can escape gravity for a few minutes.",
            author: "KENNETH CHANG"
        ),
        Article(
            url: "https://static01.nyt.com/images/2020/07/28/science/28ANCIENT-MICROBES2/28ANCIENT-MICROBES2-videoLarge.jpg",
            title: "These Microbes May Have Survived 100 Million Years Beneath the Seafloor",
            subtitle: "Rescued from their cold, cramped and nutrient-poor homes, the bacteria awoke in the lab and grew.",
            author: "KATHERINE J. WU"
        )
    ]
    
    var database = [Bookmark]()
    
     init(){
        for i in 0..<articles.count {
            database.append(Bookmark(article: articles[i], index: Int16(i)))
        }
    }
    
    func upsert(article: Article) -> Bool {
        let index = database.firstIndex { $0.article.id == article.id }
        if let index = index {
            //update
            database[index].article = article
        }else {
            //insert
            let bookmark = Bookmark(article: article, index: Int16(database.count))
            database.append(bookmark)
        }
        return true
    }
    
     func get(index: Int16) -> Bookmark? {
        let index = database.firstIndex { index == $0.index }
        
        if let index = index {
            return database[index]
        }
        
        return nil
    }
    
     func getAll() -> [Bookmark] {
        return database
    }
    
    func delete(index bookmarkIndex: Int16) -> Bool {
        let index = database.firstIndex { bookmarkIndex == $0.index }
        
        if let index = index {
            print("deleting with index:",index,database)
            database.remove(at: index)
            print("deleted with index:",index,database)
            updateOtherBookmarksIndex(after: Int16(index))
            return true
        }
        
        return false
    }
    
     func deleteAll() -> Bool {
        database.removeAll()
        return true
    }
    
     func swapIndex(source: Int16, destination: Int16) {
        let temp = database[Int(source)]
        database[Int(source)] = database[Int(destination)]
        database[Int(destination)] = temp
    }
    
     func getBookmarksCount() -> Int {
        return database.count
    }
    
    func updateOtherBookmarksIndex(after:Int16) {
        for i in Int(after)..<database.count {
            var bookmark = database[i]
            bookmark.index -= 1
            database[i] = bookmark
        }
    }
}
