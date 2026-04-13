//
//  ShowCategoryListIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct ShowCategoryListIntent: AppIntent {
    static var title: LocalizedStringResource = "Show Category List"

    func perform() async throws -> some IntentResult {
        WidgetDraftState.currentView = "categoryList"
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
