//
//  Article.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

 public class Article:NSObject,Codable {
    
     var id: UUID
     var url: String
     var title: String
     var subtitle: String
     var author: String
    
    
     init(id: UUID = UUID(),url: String, title: String, subtitle: String, author: String) {
        self.id = id
        self.url = url
        self.title = title
        self.subtitle = subtitle
        self.author = author
    }

}

