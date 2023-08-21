//
//  HTMLScarpingUtility.swift
//  NYTimes
//
//  Created by Waseem Akram on 04/08/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation
import SwiftSoup
import Combine

class HTMLScraperUtility {
    
    func scrapArticle(from data:Data) -> Future<[Article], Never> {
        Future { promise in
            let html = String(data: data, encoding: .utf8)!
            var articles = [Article]()
            do {
                let elements = try SwiftSoup.parse(html, Constants.Endpoints.BASEURL)
                // last updated: 08-20-2023
                let documents = try elements.getElementById("stream-panel")?.select("div").select("ol").select("article")
                documents?.forEach({ (document) in
                    let imageUrl = try? document.select("img").attr("src")
                    let title = try? document.select("h3").text()
                    let subtitle = try? document.select("p").text()
                    let author = try? document.select("div").select("p").select("span").text()
                    let url = try? document.select("a").attr("href")
                    
                    if let title = title,
                       let subtitle = subtitle,
                       let author = author,
                       let url = url,
                       let imageUrl = imageUrl,
                       !title.isEmpty,
                       !subtitle.isEmpty,
                       !author.isEmpty,
                       !url.isEmpty,
                       !imageUrl.isEmpty {
                        
                        let article = Article(url: "https://www.nytimes.com\(url)", imageUrl: imageUrl, title: title, subtitle: subtitle, author: author)
                        articles.append(article)
                    } else {
                        print("parsing error")
                    }
                })
                promise(.success(articles))
            } catch let error {
                debugPrint(error)
                promise(.success([]))
                return
            }
        }
    }
}

