//
//  NewsFeedViewModel.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

class ArticleViewModel:ObservableObject {
    
    var repository:ArticleRepository
    
    @Published var articles = [Article]()
    @Published var isArticlesLoading = false
    
    init(repository:ArticleRepository) {
        self.repository = repository
    }
    
    func loadArticles(for category:Category) {
        self.isArticlesLoading = true
        self.articles = []
        repository.fetchArticles(for: category) { [weak self] (articles) in
            guard let self = self else { return }
            self.isArticlesLoading = false
            if let articles = articles {
                self.articles = articles
                return
            }
        }
    }
    
}
