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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var bookmarkViewModel = BookmarkViewModel(repository: BookmarkRepository())
    
    var body: some View {
        WebView(url: url)
        .navigationBarItems(trailing: Button(action: {
            self.isBookmarked ? bookmarkViewModel.deleteBookmark(article: article,showAlert: true) : bookmarkViewModel.bookmark(for: article)
            self.isBookmarked = bookmarkViewModel.isArticleExists(with: article.url)
        }, label: {
            Image(systemName: "bookmark\(isBookmarked ? ".fill" : "")").frame(width: 30, height: 50,alignment: .center)
        }).alert(isPresented: $bookmarkViewModel.shouldShowAlert) {
            Alert(
                title: Text(bookmarkViewModel.message),
                dismissButton: .default(Text("OK"))
            )
        })
        .onAppear {
            self.isBookmarked = bookmarkViewModel.isArticleExists(with: article.url)
        }
    }
}

struct WebViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        WebViewHolder(url:URL(string: "https://google.com")!, article: articles[0])
            .previewDevice(.init(stringLiteral: "iPhone X"))
    }
}
