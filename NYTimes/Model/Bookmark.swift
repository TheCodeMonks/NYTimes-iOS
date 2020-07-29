//
//  Bookmark.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

 struct Bookmark {
    var id: UUID
    var article:Article
    var index: Int16
    
     init(from cdBookmark:CDBookmarks) {
        self.id = cdBookmark.id!
        self.article = cdBookmark.article!
        self.index = cdBookmark.index
    }
    
     init(id: UUID = UUID(), article: Article, index: Int16) {
        self.id = id
        self.article = article
        self.index = index
    }
}
