//
//  WidgetDraftState.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import Foundation

enum WidgetDraftState {
    private static let defaults: UserDefaults = {
        UserDefaults(suiteName: SharedModelContainer.appGroupID) ?? .standard
    }()

    static var type: TransactionType {
        get {
            guard let raw = defaults.string(forKey: "widgetType"),
                  let value = TransactionType(rawValue: raw) else {
                return .expense
            }
            return value
        }
        set {
            defaults.set(newValue.rawValue, forKey: "widgetType")
        }
    }

    static var amountDraft: String {
        get { defaults.string(forKey: "widgetAmountDraft") ?? "" }
        set { defaults.set(newValue, forKey: "widgetAmountDraft") }
    }

    static var selectedCategory: Category? {
        get {
            guard let raw = defaults.string(forKey: "widgetCategory") else { return nil }
            return Category(rawValue: raw)
        }
        set {
            defaults.set(newValue?.rawValue, forKey: "widgetCategory")
        }
    }

    static var currentView: String {
        get { defaults.string(forKey: "widgetCurrentView") ?? "main" }
        set { defaults.set(newValue, forKey: "widgetCurrentView") }
    }

    static func resetAll() {
        type = .expense
        amountDraft = ""
        selectedCategory = nil
        currentView = "main"
    }
}
