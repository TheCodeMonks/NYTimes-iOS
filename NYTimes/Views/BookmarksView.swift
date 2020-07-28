//
//  BookmarksView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        List{
            ForEach(0..<10) { index in
                NavigationLink(destination: Text("LOL")){
                    NewsFeedView()
                        .contextMenu(menuItems: {
                            Button(action: {
                                self.deleteBookmark(at: IndexSet(arrayLiteral: index))
                            }) {
                                Text("Delete Bookmark")
                                Image(uiImage:UIImage(systemName:"delete.left")!)
                            }
                        })
                }
            }
            .onDelete(perform: deleteBookmark(at:))
        .onMove(perform: moveBookmarks(from:to:))
        }
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: EditButton())
        .navigationBarTitle("Bookmarks", displayMode: .automatic)
    }
    
    func moveBookmarks(from source:IndexSet, to destination:Int){
        print(source.first ?? 0,destination)
    }
    
    func deleteBookmark(at offsets:IndexSet){
        print("Delete bookmark")
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}
