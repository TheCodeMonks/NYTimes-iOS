//
//  ContentView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI
import CoreData

let articles = [
    Article(
        url: "https://www.nytimes.com/2020/07/28/science/nasa-jezero-perseverance.html",
        imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28SCI-MARS-JEZERO1/28SCI-MARS-JEZERO1-jumbo.jpg",
        title: "How NASA Found the Ideal Hole on Mars to Land In",
        subtitle: "Jezero crater, the destination of the Perseverance rover, is a promising place to look for evidence of extinct Martian life.",
        author: "KENNETH CHANG"
    ),
    Article(
        url: "https://www.nytimes.com/2020/07/28/science/virgin-galactic-cabin.html",
        imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28VIRGINGALACTIC2/28VIRGINGALACTIC2-videoLarge.jpg",
        title: "Virgin Galactic Unveils Comfy Cabin for Jet-Setting to the Edge of Space",
        subtitle: "Passengers able to pay hundreds of thousands of dollars for a seat can escape gravity for a few minutes.",
        author: "KENNETH CHANG"
    ),
    Article(
        url: "https://www.nytimes.com/2020/07/28/science/microbes-100-million-years-old.html",
        imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28ANCIENT-MICROBES2/28ANCIENT-MICROBES2-videoLarge.jpg",
        title: "These Microbes May Have Survived 100 Million Years Beneath the Seafloor",
        subtitle: "Rescued from their cold, cramped and nutrient-poor homes, the bacteria awoke in the lab and grew.",
        author: "KATHERINE J. WU"
    )
]

struct RootView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var categories:[Category] = Category.allCases
    
    var initialCategory:Int
    
    @ObservedObject var articlesViewModel = ArticleViewModel(repository: ArticleRepository())
    
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
                        ProgressView("Loading").offset(x: 0, y: 50)
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
                                        Alert(
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


