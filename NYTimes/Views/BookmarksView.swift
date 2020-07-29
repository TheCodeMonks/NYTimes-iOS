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
    
    @ViewBuilder
    var body: some View {
        if savedArticles.count > 0 {
            List{
                ForEach(savedArticles,id:\.id) { savedArticle in
                    NavigationLink(destination: WebViewHolder(url: URL(string: savedArticle.url)!, article: Article(from: savedArticle))){
                        NewsFeedView(article: Article(from: savedArticle ))
                    }
                }
                .onDelete(perform: deleteBookmark(at:))
                .onMove(perform: moveBookmarks(from:to:))
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle("Bookmarks", displayMode: .automatic)
        }else{
            Text("No Bookmarks Added yet")
                .font(.system(size: 22, weight: Font.Weight.semibold, design: .rounded))
                .navigationBarTitle("Bookmarks", displayMode: .automatic)
        }
        
        
    }
    
    func moveBookmarks(from source:IndexSet, to destination:Int){
        print(source.first ?? 0,destination)
    }
    
    func deleteBookmark(at offsets:IndexSet){
        for index in offsets {
            managedObjectContext.delete(savedArticles[index])
        }
        try? managedObjectContext.save()
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}
