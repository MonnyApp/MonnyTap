//
//  ModalCategoryExpenseViewModel.swift
//  MonnyTap
//
//  Created by Assistant on 09/04/26.
//

import Foundation
import SwiftUI

final class ModalCategoryExpenseViewModel: ObservableObject {
    // The temporary selection a user makes inside the modal
    @Published var tempSelection: Category?

    // All available categories to display
    let categories: [Category]

    init(initialSelection: Category? = nil, categories: [Category] = Category.allCases) {
        self.tempSelection = initialSelection
        self.categories = categories
    }

    // User tapped a category cell
    func select(_ category: Category) {
        tempSelection = category
    }

    // Compute the value to commit when Save is tapped
    func confirmSelection(currentSelected: Category?) -> Category? {
        tempSelection ?? currentSelected
    }

    // Sync initial state when the view appears or when the binding changes
    func reset(from current: Category?) {
        tempSelection = current
    }
}
