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
    let savedFlash: SavedFlash?
}

struct SavedFlash {
    let amount: Int
    let type: TransactionType
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
            currentView: "main",
            savedFlash: nil
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (MonnyEntry) -> Void) {
        completion(makeEntry(at: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MonnyEntry>) -> Void) {
        let now = Date.now
        var entries: [MonnyEntry] = [makeEntry(at: now)]

        // If a save-confirmation flash is active, schedule a follow-up entry to clear it.
        if let flashUntil = WidgetDraftState.savedFlashUntil, flashUntil > now {
            entries.append(makeEntry(at: flashUntil, ignoreFlash: true))
        }

        completion(Timeline(entries: entries, policy: .never))
    }

    private func makeEntry(at date: Date, ignoreFlash: Bool = false) -> MonnyEntry {
        let defaults = UserDefaults(suiteName: "group.com.MonnyApp.MonnyTap")

        let typeRaw = defaults?.string(forKey: "widgetType") ?? "Expense"
        let type = TransactionType(rawValue: typeRaw) ?? .expense

        let amountDraft = defaults?.string(forKey: "widgetAmountDraft") ?? ""

        let categoryRaw = defaults?.string(forKey: "widgetCategory")
        let selectedCategory: Category? = categoryRaw.flatMap { Category(rawValue: $0) }

        let currentView = defaults?.string(forKey: "widgetCurrentView") ?? "main"

        let savedFlash: SavedFlash? = {
            guard !ignoreFlash,
                  let until = WidgetDraftState.savedFlashUntil, until > date,
                  let amount = WidgetDraftState.savedFlashAmount,
                  let flashType = WidgetDraftState.savedFlashType
            else { return nil }
            return SavedFlash(amount: amount, type: flashType)
        }()

        return MonnyEntry(
            date: date,
            type: type,
            amountDraft: amountDraft,
            selectedCategory: selectedCategory,
            topCategories: Self.defaultCategories,
            currentView: currentView,
            savedFlash: savedFlash
        )
    }
}
