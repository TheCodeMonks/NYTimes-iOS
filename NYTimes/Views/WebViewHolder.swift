//
//  WebViewHolder.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI
import CoreData

struct WebViewHolder: View {
    
    var url:URL
    var article:Article
    
    @State var isBookmarked = false
    @State var bookmarkStatus = ""
    @State var shouldAnimateForBookmark = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack{
            WebView(url: url)
                .blur(radius: shouldAnimateForBookmark ? 20 : 0)
                
            Text(bookmarkStatus)
                .transition(.slide)
                .multilineTextAlignment(.center)
                .font(.system(size: 32, weight: .medium, design: .rounded))
                .opacity(shouldAnimateForBookmark ? 1 : 0)
                .blur(radius: 0)
        }
        
        .animation(Animation.easeInOut(duration: 0.5))
        .navigationBarItems(trailing: Button(action: {
            isBookmarked ? deleteBookmark() : addBookmark()
        }, label: {
            Image(systemName: "bookmark\(isBookmarked ? ".fill" : "")").frame(width: 30, height: 50,alignment: .center)
        }))
        .onAppear {
            isBookmarked = isAlreadyBookmarked()
        }
    
    }
    
    func isAlreadyBookmarked()-> Bool{
        do {
            let fetchRequest:NSFetchRequest<CDArticle> = CDArticle.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "url == %@", article.url)
            let results = try managedObjectContext.fetch(fetchRequest)
            if results.first != nil {
                return true
            }
        }catch let error {
            debugPrint(error)
        }
        return false
    }
    
    func addBookmark(){
        do {
            let cdArticle = CDArticle(context: managedObjectContext)
            cdArticle.set(from: article)
            if managedObjectContext.hasChanges {
                try managedObjectContext.save()
                bookmarkStatus = "Added to Bookmarks"
                shouldAnimateForBookmark = true
                isBookmarked = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1200)) {
                    shouldAnimateForBookmark = false
                    
                }
            }
            
        }catch let error {
            debugPrint(error)
        }
        
    }
    
    func deleteBookmark(){
        do {
            let fetchRequest:NSFetchRequest<CDArticle> = CDArticle.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "url == %@", article.url)
            let results = try managedObjectContext.fetch(fetchRequest)
            if let article = results.first {
                managedObjectContext.delete(article)
                try managedObjectContext.save()
                bookmarkStatus = "Removed from Bookmarks"
                shouldAnimateForBookmark = true
                isBookmarked = false
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1200)) {
                    shouldAnimateForBookmark = false
                    
                }
                
            }
        }catch let error {
            debugPrint(error)
        }
    }
    
    
}

struct WebViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        WebViewHolder(url:URL(string: "https://google.com")!, article: articles[0])
            .previewDevice(.init(stringLiteral: "iPhone X"))
    }
}
