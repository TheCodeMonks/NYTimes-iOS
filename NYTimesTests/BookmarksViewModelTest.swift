//
//  BookmarksViewModelTest.swift
//  NYTimesTests
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import XCTest
@testable import NYTimes

class BookmarksViewModelTest: XCTestCase {

    var bookmarksViewModel:BookmarksViewModel!
    
    override func setUp() {
        bookmarksViewModel = BookmarksViewModel(repository: PlaceholderBookmarksRepository())
    }
    
        
    func testInsertBookmarks(){
        let expectedIndex = bookmarksViewModel.bookmarks.count
        let article = Article(url: "url", title: "testTitle", subtitle: "testSubtitle", author: "testAuthor")
        bookmarksViewModel.upsertBookmark(article: article) { (success) in
            XCTAssertTrue(success)
        }
        bookmarksViewModel.get(index: Int16(expectedIndex)) { (result) in
         XCTAssertNotNil(result)
            if let result = result {
                XCTAssertEqual(article, result.article)
                XCTAssertEqual(article.id, result.article.id)
            }
        }
    }
    
    func testUpdateBookmarks(){
        
        let updatableBookmark = bookmarksViewModel.bookmarks[0]
        let article = updatableBookmark.article
        article.author = "Changed Author"
        article.title = "Changed title"
        
        bookmarksViewModel.upsertBookmark(article: article) { (success) in
            XCTAssertTrue(success)
        }
        
        bookmarksViewModel.get(index: updatableBookmark.index) { (result) in
            XCTAssertNotNil(result)
            if let result = result {
                XCTAssertEqual(updatableBookmark.id, result.id)
                XCTAssertEqual(updatableBookmark.article, result.article)
                XCTAssertEqual(updatableBookmark.index, result.index)
                
                XCTAssertEqual(article.id, result.article.id)
            }
        }
    }
        
    func testDeleteBookmarks(){
        //create a bookmark to delete
        let deletableBookmark = bookmarksViewModel.bookmarks[0]
        
        //delete the bookmark
        bookmarksViewModel.deleteBookmark(index: deletableBookmark.index) { (success) in
            XCTAssertTrue(success)
        }
        
        //check if bookmark deleted, if deleted, then other bookmark should show up
        bookmarksViewModel.get(index: deletableBookmark.index) { (result) in
            XCTAssertNotNil(result)
            XCTAssertNotEqual(deletableBookmark.id,result?.id)
        }

    }
    
    
    func testSwapBookmarks(){
//        bookmarksViewModel.swapBookmark(from: <#T##Int#>, to: <#T##Int#>)
    }
        
}
