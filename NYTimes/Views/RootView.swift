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

    @State var categories: [Category] = Category.allCases

    var initialCategory: Int
    
    @ObservedObject var articlesViewModel = ArticleViewModel()
    @ObservedObject var bookmarkViewModel = BookmarkViewModel()
    @ObservedObject var networkReachability = NetworkReachabilty.shared

    @State var shouldShowBookmarks = false
    @State var openCategories = false
    @State var isLoaded = false

    init() {
        initialCategory = 0
        articlesViewModel.loadArticles(for: categories[initialCategory])
    }
    
    var body: some View {
        NavigationView {
            if networkReachability.isNetworkConnected {
                ArticleView()
                    .edgesIgnoringSafeArea(.all)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .navigationBarTitle(Text("NYTimes"))
                    .navigationBarItems(
                        leading: categoriesView,
                        trailing: bookmarksView
                    )
            } else {
                VStack {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 50))
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(.bottom, 24)
                    Text("Network not available")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("Network not available"), message: Text("Turn on mobile data or use Wi-Fi to access data"), dismissButton: .default(Text("OK")))
                        }.navigationBarTitle(Text("NYTimes"))
                }
            }
        }.onAppear {
            let repo = BookmarkRepository(context: managedObjectContext)
            bookmarkViewModel.repository = repo
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(650)) {
                isLoaded = true
            }
            if let categories = UserDefaults.standard
                .array(forKey: Constants.UserDefaults.categories) as? [String] {
                self.categories = categories.map({ Category(rawValue: $0)! })
            }
            articlesViewModel.loadArticles(for: categories[initialCategory])
        }
    }

    func updateCategories(_ categories: [Category]) {
        self.categories = categories
    }

    private var categoriesView: some View {
        Button(action: { openCategories = true }, label: {
            Image(systemName: "square.stack.3d.up")
                .frame(width: 30, height: 50, alignment: .center)
        })
    }

    private var bookmarksView: some View {
        Button(action: { shouldShowBookmarks = true }, label: {
            Image(systemName: "folder")
                .frame(width: 30, height: 50, alignment: .center)
        })
    }
    
    fileprivate func ArticleView() -> some View {
        return VStack {
            NavigationLink(destination: BookmarksView(), isActive: $shouldShowBookmarks) {}
            NavigationLink(destination: CategoriesView(viewModel: CategoriesViewModel(updateCategories)), isActive: $openCategories) {}
            if articlesViewModel.isArticlesLoading {
                VStack{
                    Spacer()
                    ForEach(0..<3) { i in
                        NewsFeedView(article: .placeholder)
                    }.redacted(reason: .placeholder)
                    Spacer()
                }
            } else {
                ArticleListView(articlesViewModel: articlesViewModel, bookmarkViewModel: bookmarkViewModel)
            }
            Spacer()
            CategorySelector(
                categories: categories,
                articleViewModel: articlesViewModel,
                selectedCategory: initialCategory
            ).frame(height: 100).offset(y: isLoaded ? 0 : 100)
                .animation(isLoaded ? .spring() : .none)
        }
    }
}


struct ArticleListView: View {
    
    @ObservedObject var articlesViewModel: ArticleViewModel
    @ObservedObject var bookmarkViewModel: BookmarkViewModel
    
    var body: some View {
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
        .listStyle(InsetGroupedListStyle())
        .padding(.bottom, -8)
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView()
                .previewDevice(.init(stringLiteral: "iPhone 11"))
        }
    }
}
