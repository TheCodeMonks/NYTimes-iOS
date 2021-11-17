//
//  CategorySelector.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI

struct CategorySelector: View {
    
    @EnvironmentObject var categoriesViewModel: CategoriesViewModel
    @EnvironmentObject var articleViewModel: ArticleViewModel

    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categoriesViewModel.categories, id: \.rawValue) { category in
                        VStack{
                            Spacer()
                            HStack {
                                Text(category.rawValue)
                                    .foregroundColor(categoriesViewModel.selectedCategory == category ? .white : .init(UIColor.label))
                                    .fontWeight(.medium)
                            }
                            .padding(.leading,16)
                            .padding(.trailing,16)
                            Spacer()
                        }
                        .background(categoriesViewModel.selectedCategory == category ? Color.purple : Color("categoryBackground"))
                            .cornerRadius(10)
                            .onTapGesture {
                                categoriesViewModel.selectedCategory = category
                                articleViewModel.loadArticles(for: category)
                        }
                    }.padding(.leading,8)
                }
            }
            .padding(.vertical,24)
            .background(Color.init(.secondarySystemBackground))
            .clipped()
            .shadow(radius: 15)
    }
        
}



struct CategorySelector_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelector()
            .environmentObject(ArticleViewModel())
            .environmentObject(CategoriesViewModel())
            .previewDevice(.init("iPhone X"))
            
    }
}


