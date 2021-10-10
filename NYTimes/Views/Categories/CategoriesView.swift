//
//  CategoriesView.swift
//  NYTimes
//
//  Created by Sameer Nawaz on 09/10/21.
//  Copyright © 2021 Waseem Akram. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {

    @StateObject var viewModel: CategoriesViewModel

    var body: some View {
        List {
            ForEach(0..<viewModel.categories.count, id: \.self) { i in
                Text(viewModel.categories[i].rawValue)
            }.onMove(perform: viewModel.move)
        }
        .toolbar { EditButton() }
        .navigationBarTitle("Categories", displayMode: .automatic)
    }
}
