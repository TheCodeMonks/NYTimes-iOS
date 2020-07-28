//
//  NewsFeedView.swift
//  NYTimes
//
//  Created by Waseem Akram on 28/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import SwiftUI

struct NewsFeedView: View {
    var body: some View {
        HStack {
            Image("placeholder")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .clipped()
                .cornerRadius(12)
                
                
            VStack(alignment: .leading, spacing: 8) {
                Text("Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ")
                
                    .font(.headline)
                    .lineLimit(2)
                    
                Text("Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")
                    .font(.subheadline)
                    .opacity(0.7)
                    .lineLimit(2)
                    
                Text("Author")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.leading)
            }.padding(.horizontal, 12)
        }
        .padding(12)
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
//            .previewDevice(.init(stringLiteral: "iPhone X"))
//            .edgesIgnoringSafeArea(.all)
//            .environment(\.colorScheme, .dark)
    }
}
