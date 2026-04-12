//
//  MonnyTapWidgetProvider.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import WidgetKit
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
    private static let defaultCategories: [Category] = [.fnb, .shopping, .transportation]

    func placeholder(in context: Context) -> MonnyEntry {
        MonnyEntry(
            date: .now,
            type: .expense,
            amountDraft: "",
            selectedCategory: nil,
            topCategories: Self.defaultCategories,
            currentView: "main"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (MonnyEntry) -> Void) {
        completion(makeEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MonnyEntry>) -> Void) {
        let entry = makeEntry()
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func makeEntry() -> MonnyEntry {
        let defaults = UserDefaults(suiteName: "group.com.MonnyApp.MonnyTap")

        let typeRaw = defaults?.string(forKey: "widgetType") ?? "Expense"
        let type = TransactionType(rawValue: typeRaw) ?? .expense

        let amountDraft = defaults?.string(forKey: "widgetAmountDraft") ?? ""

        let categoryRaw = defaults?.string(forKey: "widgetCategory")
        let selectedCategory: Category? = categoryRaw.flatMap { Category(rawValue: $0) }

        let currentView = defaults?.string(forKey: "widgetCurrentView") ?? "main"

        return MonnyEntry(
            date: .now,
            type: type,
            amountDraft: amountDraft,
            selectedCategory: selectedCategory,
            topCategories: Self.defaultCategories,
            currentView: currentView
        )
    }
}
