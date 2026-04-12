//
//  MonnyTapWidgetProvider.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import WidgetKit
import SwiftData
import Foundation

struct MonnyEntry: TimelineEntry {
    let date: Date
    let type: TransactionType
    let amountDraft: String
    let selectedCategory: Category?
    let topCategories: [Category]
    let currentView: String
}

struct MonnyTapWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> MonnyEntry {
        MonnyEntry(
            date: .now,
            type: .expense,
            amountDraft: "",
            selectedCategory: nil,
            topCategories: [.fnb, .shopping, .transportation],
            currentView: "main"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (MonnyEntry) -> Void) {
        let entry = MonnyEntry(
            date: .now,
            type: .expense,
            amountDraft: "",
            selectedCategory: nil,
            topCategories: [.fnb, .shopping, .transportation],
            currentView: "main"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MonnyEntry>) -> Void) {
        let type = WidgetDraftState.type
        let amountDraft = WidgetDraftState.amountDraft
        let selectedCategory = WidgetDraftState.selectedCategory
        let currentView = WidgetDraftState.currentView

        let topCategories = fetchTopCategories()

        let entry = MonnyEntry(
            date: .now,
            type: type,
            amountDraft: amountDraft,
            selectedCategory: selectedCategory,
            topCategories: topCategories,
            currentView: currentView
        )

        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func fetchTopCategories() -> [Category] {
        let container = SharedModelContainer.modelContainer
        let context = ModelContext(container)

        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: .now)!
        let expenseRaw = TransactionType.expense.rawValue

        let descriptor = FetchDescriptor<Transaction>(
            predicate: #Predicate {
                $0.type.rawValue == expenseRaw && $0.date >= thirtyDaysAgo
            }
        )

        guard let transactions = try? context.fetch(descriptor) else {
            return [.fnb, .shopping, .transportation]
        }

        var totals: [Category: Int] = [:]
        for transaction in transactions {
            if let category = transaction.category {
                totals[category, default: 0] += transaction.amount
            }
        }

        let sorted = totals.sorted { $0.value > $1.value }
        let top = sorted.prefix(3).map(\.key)

        if top.isEmpty {
            return [.fnb, .shopping, .transportation]
        }

        return Array(top)
    }
}
