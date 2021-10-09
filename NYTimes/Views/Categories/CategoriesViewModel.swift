//
//  CategoriesViewModel.swift
//  NYTimes
//
//  Created by Sameer Nawaz on 09/10/21.
//  Copyright © 2021 Waseem Akram. All rights reserved.
//

import Foundation

class CategoriesViewModel: ObservableObject {

    @Published private(set) var categories: [Category] = Category.allCases {
        didSet { saveCategories() }
    }

    init() {}

    func move(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
    }

    private func saveCategories() {

    }
}
