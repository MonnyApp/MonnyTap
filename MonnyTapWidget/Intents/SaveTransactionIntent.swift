//
//  SaveTransactionIntent.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import SwiftData
import WidgetKit

struct SaveTransactionIntent: AppIntent {
    static var title: LocalizedStringResource = "Save Transaction"

    func perform() async throws -> some IntentResult {
        let type = WidgetDraftState.type
        let amountString = WidgetDraftState.amountDraft
        let category = WidgetDraftState.selectedCategory

        guard let amount = Int(amountString), amount > 0 else {
            return .result()
        }

        let resolvedCategory: Category = {
            if type == .income {
                return .income
            }
            return category ?? .other
        }()

        let container = SharedModelContainer.modelContainer
        let context = ModelContext(container)

        let transaction = Transaction(
            type: type,
            title: "",
            amount: amount,
            date: .now,
            category: resolvedCategory
        )

        context.insert(transaction)
        try context.save()

        WidgetDraftState.resetAll()
        WidgetCenter.shared.reloadTimelines(ofKind: "MonnyTapWidget")
        return .result()
    }
}
