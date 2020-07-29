//
//  BookmarksViewModel.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation


class BookmarksViewModel:ObservableObject {
        
    private var repository: BookmarksRepository
    
    typealias BooleanClosure = ((Bool)->Void)
    
    @Published var bookmarks = [Bookmark]()
    
    init(repository: BookmarksRepository) {
        self.repository = repository
        getAllBookmarks()
    }
    
    func get(index:Int16,completion: (Bookmark?)->Void) {
        completion(repository.get(index: index))
    }
    
    func upsertBookmark(article:Article,completion: BooleanClosure){
        completion(repository.upsert(article: article))
    }
    
    func deleteBookmark(index:Int16,completion: BooleanClosure) {
        completion(repository.delete(index: index))
        getAllBookmarks()
    }
        
    func swapBookmark(from source: Int16, to destination: Int16){
        repository.swapIndex(source: source, destination: destination)
        
    }
    
    func getAllBookmarks(){
        self.bookmarks = repository.getAll()
    }
    
}
