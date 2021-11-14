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
        didSet {
            saveCategories()
        }
    }
    
    @Published var selectedCategory: Category = Category.tech
    
    @Published var categoriesUnfollowed: [Category] = []

    init() {
        if let categories = UserDefaults.standard
            .array(forKey: Constants.UserDefaults.categories) as? [String] {
            self.categories = categories.map({ Category(rawValue: $0)! })
            updateUnfollowedCategories()
            selectedCategory = self.categories[0]
        }
    }
    
    func updateUnfollowedCategories() {
        for category in Category.allCases {
            if !categories.contains(where: {$0.rawValue == category.rawValue}) {
                categoriesUnfollowed.append(category)
            }
        }
    }
    
    func addCategory(_ category: Category) {
        categoriesUnfollowed = categoriesUnfollowed.filter {$0.rawValue != category.rawValue}
        categories.append(category)
    }
    
    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        categoriesUnfollowed.append(categories[index])
        categories.remove(atOffsets: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
    }

    private func saveCategories() {
        let categories = categories.map({ $0.rawValue })
        UserDefaults.standard.set(categories, forKey: Constants.UserDefaults.categories)
    }
}
