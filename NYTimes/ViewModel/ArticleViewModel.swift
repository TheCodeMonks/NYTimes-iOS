//
//  NewsFeedViewModel.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

class ArticleViewModel:ObservableObject {
    
    var httpUtility = HTTPUtility()
    var htmlScrapUtlity = HTMLScraperUtility()
    
    @Published var articles = [Article]()
    @Published var isArticlesLoading = false
    
 
    func loadArticles(for category:Category) {
        self.isArticlesLoading = true
        self.articles = []
        httpUtility.fetch(using: URL(string: category.url)!) { [weak self] (data) in
            guard let self = self else { return }
            if let data = data {
                self.htmlScrapUtlity.scrapArticleFrom(data: data) { [weak self] (articles) in
                    guard let self = self else { return }
                    self.isArticlesLoading = false
                    if let articles = articles {
                        self.articles = articles
                        return
                    }
                }
            }
        }
    }
    
}
