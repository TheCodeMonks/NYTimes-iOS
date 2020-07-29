//
//  BookmarksRepository.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

protocol Repository:class {
 
    associatedtype T

    func upsert(data:T) -> Bool
    func get(id:UUID) -> T?
    func getAll() -> [T]
    func delete(id:UUID) -> Bool
    func deleteAll() -> Bool
    
}

