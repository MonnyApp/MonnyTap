//
//  ClearIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct ClearIntent: AppIntent {
    static var title: LocalizedStringResource = "Clear Amount"

    func perform() async throws -> some IntentResult {
        WidgetDraftState.amountDraft = ""
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
