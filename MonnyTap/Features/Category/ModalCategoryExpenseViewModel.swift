//
//  ModalCategoryExpenseViewModel.swift
//  MonnyTap
//
//  Created by Assistant on 09/04/26.
//

//
//  ModalCategoryExpenseViewModel.swift
//  MonnyTap
//
//  Created by Assistant on 09/04/26.
//

import Foundation

@Observable
final class ModalCategoryExpenseViewModel {
    // Full list of categories to display. Defaults to all enum cases.
    var categories: [Category] = Category.allCases

    // Ephemeral selection used inside the modal until user confirms.
    var tempSelection: Category?

    // Optional search query to filter categories by name.
    var searchText: String = ""

    init(initialSelection: Category? = nil) {
        self.tempSelection = initialSelection
    }

    // Returns the list filtered by search text (case-insensitive).
    var filteredCategories: [Category] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return categories }
        let lower = query.lowercased()
        return categories.filter { $0.rawValue.lowercased().contains(lower) }
    }

    // MARK: - Selection

    func select(_ category: Category) {
        tempSelection = category
    }

    func isSelected(_ category: Category) -> Bool {
        tempSelection == category
    }

    /// Returns the selection to commit back to the parent.
    /// - Parameter currentSelection: The current selection owned by the parent view.
    /// - Returns: The new selection to apply.
    func confirmSelection(currentSelection: Category?) -> Category? {
        tempSelection ?? currentSelection
    }

    func clear() {
        tempSelection = nil
        searchText = ""
    }
}
