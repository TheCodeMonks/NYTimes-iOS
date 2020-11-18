//
//  Article.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

public class Article:NSObject,Codable,Identifiable {
    
    public var id: UUID
    var url: String
    var title: String
    var subtitle: String
    var author: String
    var imageUrl:String
    
    
    init(id: UUID = UUID(),url: String, imageUrl:String,title: String, subtitle: String, author: String) {
        self.id = id
        self.url = url
        self.title = title
        self.subtitle = subtitle
        self.author = author
        self.imageUrl = imageUrl
    }
    
    init(from dataArticle:CDArticle){
        self.id = dataArticle.id
        self.url = dataArticle.url
        self.title = dataArticle.title
        self.subtitle = dataArticle.subtitle
        self.author = dataArticle.author
        self.imageUrl = dataArticle.imageUrl
    }
    
   
    static var placeholder = Article(url: "Url", imageUrl: "imageUrl", title: String(repeating: "Title", count: 5), subtitle: String(repeating: "Subtitle", count: 10), author: String(repeating: "Author", count: 3))
    
}

