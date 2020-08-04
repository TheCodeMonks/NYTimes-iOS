//
//  BookmarksView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI
import CoreData

struct BookmarksView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: CDArticle.entity(), sortDescriptors: [], predicate: nil, animation: Animation.linear)
    var savedArticles:FetchedResults<CDArticle>
    
    @ObservedObject var bookmarkViewModel = BookmarkViewModel()
    
    @ViewBuilder
    var body: some View {
            List{
                ForEach(savedArticles,id:\.id) { savedArticle in
                    NavigationLink(destination: WebViewHolder(url: URL(string: savedArticle.url)!, article: Article(from: savedArticle))){
                        NewsFeedView(article: Article(from: savedArticle ))
                    }
                }
                .onDelete(perform: deleteBookmark(at:))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle("Bookmarks", displayMode: .automatic)
            .onAppear {
                self.bookmarkViewModel.repository = BookmarkRepository(context: self.managedObjectContext)
            }
    }
        
    func deleteBookmark(at offsets:IndexSet){
        for index in offsets {
            bookmarkViewModel.deleteBookmark(article: savedArticles[index])
        }
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}
