//
//  AppendDigitIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct AppendDigitIntent: AppIntent {
    static var title: LocalizedStringResource = "Append Digit"

    @Parameter(title: "Digit")
    var digit: String

    init() {}

    init(digit: String) {
        self.digit = digit
    }

    func perform() async throws -> some IntentResult {
        WidgetDraftState.amountDraft += digit
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
