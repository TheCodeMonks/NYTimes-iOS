//
//  ArticleRepositoryTest.swift
//  NYTimesTests
//
//  Created by Waseem Akram on 31/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import XCTest
@testable import NYTimes

class ArticleRepositoryTest: XCTestCase {

    var articleRepository: ArticleRepository!

    override func setUp() {
        articleRepository = ArticleRepository()
    }
    
    func testScienceArticles(){
        articleRepository.fetchArticles(for: .science) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty science articles")
        }
    }
    
    func testSportsArticles(){
        articleRepository.fetchArticles(for: .sports) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty sports articles")
        }
    }
    
    func testTechArticles(){
        articleRepository.fetchArticles(for: .tech) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty tech articles")
        }
    }
    
    func testBusinessArticles(){
        articleRepository.fetchArticles(for: .business) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty business articles")
        }
    }
    
    func testYourMoneyArticles(){
        articleRepository.fetchArticles(for: .yourmoney) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty your money articles")
        }
    }
    
    func testEducationArticles(){
        articleRepository.fetchArticles(for: .education) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty education articles")
        }
    }
    
    func testSpaceArticles(){
        articleRepository.fetchArticles(for: .space) { (articles) in
            XCTAssertNotNil(articles)
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Empty space articles")
        }
    }
    
    override func tearDown() {
        articleRepository = nil
    }

}
