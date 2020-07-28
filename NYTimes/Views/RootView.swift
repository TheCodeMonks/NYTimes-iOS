//
//  ContentView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @State var categories:[Category] = [
        Category(name: "Science"),
        Category(name: "Technology")
    ]
    
    @State var selectedCategoryIndex:Int = 0
    @State var shouldShowBookmarks = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: BookmarksView(), isActive: $shouldShowBookmarks) {EmptyView()}
                List(0..<10){ _ in
                    NavigationLink(destination: Text("LOL")){
                        NewsFeedView()
                        .contextMenu(menuItems: {
                           Button(action: {
                              print("Bookmark")
                            }) {
                                Text("Bookmark")
                                Image(uiImage:UIImage(systemName:"bookmark")!)
                            }
                        })
                    }
                }
                .padding(.bottom, -8)
                Spacer()
                CategorySelector(categories: categories, selectedCategory: $selectedCategoryIndex)
                    .frame(height:100)
                }.edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle(Text("NYTimes"))
                .navigationBarItems(trailing: Button(action: {
                    self.shouldShowBookmarks.toggle()
                }, label: {
                    Image(systemName: "bookmark").frame(width: 30, height: 50,alignment: .center)
                }))
        }

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .previewDevice(.init(stringLiteral: "iPhone X"))
//            .environment(\.colorScheme, .dark)
    }
}
