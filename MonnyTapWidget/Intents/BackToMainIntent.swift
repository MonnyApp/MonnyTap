//
//  BackToMainIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct BackToMainIntent: AppIntent {
    static var title: LocalizedStringResource = "Back to Main"

    func perform() async throws -> some IntentResult {
        WidgetDraftState.currentView = "main"
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
