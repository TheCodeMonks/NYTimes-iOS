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
    
    
    var categories:[Category] = Category.allCases
    
    var initialCategory = 0
    
    @ObservedObject var articlesViewModel = ArticleViewModel(repository: ArticleRepository())
    
    @State var shouldShowBookmarks = false
    
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
                            NewsFeedViewWithConfiguration(article: article)
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
            .onAppear {
                articlesViewModel.loadArticles(for: categories[initialCategory])
            }
        }

    }
    
    
    
}

struct NewsFeedViewWithConfiguration: View {
    
    var article:Article
    @State var showBookmarksAlert:Bool = false
    
    @State var alertMessage = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NewsFeedView(article: article)
            .contextMenu(menuItems: {
                Button(action: {
                    bookmark(with: article)
                }) {
                    Text("Bookmark")
                    Image(uiImage:UIImage(systemName:"bookmark")!)
                }
                .alert(isPresented: $showBookmarksAlert) {
                    Alert(
                        title: Text(self.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            })
    }
    
    func bookmark(with article:Article){
        
        do {
            
            let fetchRequest:NSFetchRequest<CDArticle> = CDArticle.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "url==%@", article.url)
            let objectCount = try managedObjectContext.count(for: fetchRequest)
            if objectCount > 0 {
                showAlert(message: "Bookmark already exists!")
                return
            }
            
            let count = try managedObjectContext.count(for: CDArticle.fetchRequest())
            let savedArticle = CDArticle(context: managedObjectContext)
            savedArticle.id = article.id
            savedArticle.title = article.title
            savedArticle.subtitle = article.subtitle
            savedArticle.author = article.author
            savedArticle.imageUrl = article.imageUrl
            savedArticle.url = article.url
            savedArticle.index = Int16(count)
            if managedObjectContext.hasChanges {
                try managedObjectContext.save()
                showAlert(message: "Added to Bookmark")
            }
            
        }catch let error {
            debugPrint(error)
            showAlert(message: "Error adding Bookmark")
            return
        }
    }
    
    func showAlert(message:String){
        self.alertMessage = message
        self.showBookmarksAlert = true
    }
}

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


