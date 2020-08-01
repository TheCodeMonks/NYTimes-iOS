//
//  BookmarkViewModel.swift
//  NYTimes
//
//  Created by Waseem Akram on 31/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation
import Combine

class BookmarkViewModel:ObservableObject {
    
    var repository:BookmarkRepository!
    
    @Published var message = String()
    @Published var shouldShowAlert = false
    
    init(repository:BookmarkRepository) {
        self.repository = repository
    }
    
    init(){
        
    }
    
    func isArticleExists(with URL:String) -> Bool{
        return repository.isArticleExists(with: URL)
    }
    
    
    func bookmark(for article:Article){
        if isArticleExists(with: article.url) {
            handleExisitingArticle()
            return
        }
        
        repository.insert(article: article) { [weak self] (success) in
            guard let self = self else { return }
            self.showAlertForAddedBookmark(success: success)
        }
    }
    
    func bookmark(for article:CDArticle){
        
        if isArticleExists(with: article.url) {
            handleExisitingArticle()
            return
        }
        
        repository.insert(article: article) { [weak self] (success) in
            guard let self = self else { return }
            self.showAlertForAddedBookmark(success: success)
        }
    }
    
    func deleteBookmark(article:Article, showAlert: Bool = false){
        repository.delete(article: article) { [weak self] (success) in
            guard let self = self else { return }
            if showAlert {
                self.showAlertForDeletedBookmark(success: success)
            }
        }
    }
    
    func deleteBookmark(article:CDArticle, showAlert: Bool = false){
        repository.delete(article: article) { [weak self] (success) in
            guard let self = self else { return }
            if showAlert {
                self.showAlertForDeletedBookmark(success: success)
            }
        }
    }
        
    private func handleExisitingArticle() {
        self.shouldShowAlert = true
        self.message = "Bookmark exists already!"
    }
    
    private func showAlertForAddedBookmark(success:Bool){
        self.shouldShowAlert = true
        self.message = success ? "Added to Bookmarks" : "Error Bookmarking this article"
    }
    
    private func showAlertForDeletedBookmark(success:Bool){
        self.shouldShowAlert = true
        self.message = success ? "Removed from bookmarks" : "Error deleting this article from bookmarks"
    }
}
