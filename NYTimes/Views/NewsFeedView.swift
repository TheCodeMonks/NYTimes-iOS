//
//  NewsFeedView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct NewsFeedView: View {
    
    var article:Article
    
    var body: some View {
        HStack {
            KFImage(URL(string: article.imageUrl)!)
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .clipped()
                .cornerRadius(12)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    
                    .font(.headline)
                    .lineLimit(2)
                
                Text(article.subtitle)
                    .font(.subheadline)
                    .opacity(0.7)
                    .lineLimit(2)
                
                Text(article.author)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.leading)
            }.padding(.horizontal, 12)
        }
        .padding(12)
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(article: Article(
            url: "https://static01.nyt.com/images/2020/07/28/science/28SCI-MARS-JEZERO1/28SCI-MARS-JEZERO1-jumbo.jpg",
            imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28SCI-MARS-JEZERO1/28SCI-MARS-JEZERO1-jumbo.jpg",
            title: "How NASA Found the Ideal Hole on Mars to Land In",
            subtitle: "Jezero crater, the destination of the Perseverance rover, is a promising place to look for evidence of extinct Martian life.",
            author: "KENNETH CHANG"
        ))
        //            .previewDevice(.init(stringLiteral: "iPhone X"))
        //            .edgesIgnoringSafeArea(.all)
        //            .environment(\.colorScheme, .dark)
    }
}
