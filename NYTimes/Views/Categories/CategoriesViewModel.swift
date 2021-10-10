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

    init() {
        if let categories = UserDefaults.standard
            .array(forKey: Constants.UserDefaults.categories) as? [String] {
            self.categories = categories.map({ Category(rawValue: $0)! })
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
    }

    private func saveCategories() {
        let categories = categories.map({ $0.rawValue })
        UserDefaults.standard.set(categories, forKey: Constants.UserDefaults.categories)
    }
}
