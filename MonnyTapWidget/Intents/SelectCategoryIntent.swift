//
//  SelectCategoryIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct SelectCategoryIntent: AppIntent {
    static var title: LocalizedStringResource = "Select Category"

    @Parameter(title: "Category")
    var categoryRaw: String

    init() {}

    init(categoryRaw: String) {
        self.categoryRaw = categoryRaw
    }

    func perform() async throws -> some IntentResult {
        if let category = Category(rawValue: categoryRaw) {
            WidgetDraftState.selectedCategory = category
        }
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
