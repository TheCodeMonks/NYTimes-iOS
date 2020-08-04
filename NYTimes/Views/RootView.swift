//
//  ContentView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI
import CoreData



struct RootView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var categories:[Category] = Category.allCases
    
    var initialCategory:Int
    
    @ObservedObject var articlesViewModel = ArticleViewModel()
    
    @ObservedObject var bookmarkViewModel = BookmarkViewModel()
    
    @State var shouldShowBookmarks = false
    
    init() {
        initialCategory = 0
        articlesViewModel.loadArticles(for: categories[initialCategory])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: BookmarksView(), isActive: $shouldShowBookmarks) {EmptyView()}
                if articlesViewModel.isArticlesLoading {
                    VStack{
                        Spacer()
                        ForEach(0..<3) { i in
                            NewsFeedView(article: Article(url: "Url", imageUrl: "imageUrl", title: "TitleTitleTitleTitle", subtitle: "SubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitleSubtitle", author: "AuthorAuthor"))
                        }.redacted(reason: .placeholder)
                        Spacer()
                    }
                }else{
                    List(articlesViewModel.articles, id: \.id){ article in
                        NavigationLink(destination: WebViewHolder(url: URL(string: article.url)!, article: article)){
                            NewsFeedView(article: article)
                                .contextMenu(menuItems: {
                                    Button(action: {
                                        bookmarkViewModel.bookmark(for: article)
                                    }) {
                                        Text("Bookmark")
                                        Image(uiImage:UIImage(systemName:"bookmark")!)
                                    }
                                    .alert(isPresented: $bookmarkViewModel.shouldShowAlert) {
                                        return Alert(
                                            title: Text(bookmarkViewModel.message),
                                            dismissButton: .default(Text("OK"))
                                        )
                                    }
                                })
                        }
                    }
                    .padding(.bottom, -8)
                }
                Spacer()
                CategorySelector(categories: categories, articleViewModel: articlesViewModel,selectedCategory: initialCategory)
                    .frame(height:100)
                }.edgesIgnoringSafeArea(.all)
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle(Text("NYTimes"))
                .navigationBarItems(trailing: Button(action: {
                    self.shouldShowBookmarks.toggle()
                }, label: {
                    Image(systemName: "folder").frame(width: 30, height: 50,alignment: .center)
                }))
        }.onAppear {
            let repo = BookmarkRepository(context: managedObjectContext)
            bookmarkViewModel.repository = repo
        }

    }
    
    
    
}

//struct NewsFeedViewWithConfiguration: View {
//    
//    
//    var bookmarkViewModel:BookmarkViewModel
//    
//    var article:Article
//   
//    
//    var body: some View {
//        
//            
//        }
//}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView()
                
                .previewDevice(.init(stringLiteral: "iPhone X"))
//                        .environment(\.colorScheme, .dark)
//            RootView()
//                .previewDevice(.init(stringLiteral: "iPad Pro (9.7-inch)"))
                        
        }

    }
}


