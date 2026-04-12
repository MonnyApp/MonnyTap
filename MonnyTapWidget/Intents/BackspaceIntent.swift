//
//  BackspaceIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct BackspaceIntent: AppIntent {
    static var title: LocalizedStringResource = "Backspace"

    func perform() async throws -> some IntentResult {
        if !WidgetDraftState.amountDraft.isEmpty {
            WidgetDraftState.amountDraft.removeLast()
        }
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
