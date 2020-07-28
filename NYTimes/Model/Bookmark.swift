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
    var url: String
    var title: String
    var subtitle: String
    var author: String
    var index: Int16
}
