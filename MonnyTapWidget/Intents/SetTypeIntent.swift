//
//  SetTypeIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import WidgetKit

struct SetTypeIntent: AppIntent {
    static var title: LocalizedStringResource = "Set Transaction Type"

    @Parameter(title: "Type")
    var typeRaw: String

    init() {}

    init(typeRaw: String) {
        self.typeRaw = typeRaw
    }

    func perform() async throws -> some IntentResult {
        if let type = TransactionType(rawValue: typeRaw) {
            WidgetDraftState.type = type
        }
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
