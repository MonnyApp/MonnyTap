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

    // MARK: - Save confirmation flash

    static var savedFlashAmount: Int? {
        get {
            let value = defaults.integer(forKey: "widgetSavedFlashAmount")
            return value == 0 ? nil : value
        }
        set { defaults.set(newValue ?? 0, forKey: "widgetSavedFlashAmount") }
    }

    static var savedFlashType: TransactionType? {
        get {
            guard let raw = defaults.string(forKey: "widgetSavedFlashType") else { return nil }
            return TransactionType(rawValue: raw)
        }
        set { defaults.set(newValue?.rawValue, forKey: "widgetSavedFlashType") }
    }

    static var savedFlashUntil: Date? {
        get {
            let ts = defaults.double(forKey: "widgetSavedFlashUntil")
            return ts == 0 ? nil : Date(timeIntervalSince1970: ts)
        }
        set { defaults.set(newValue?.timeIntervalSince1970 ?? 0, forKey: "widgetSavedFlashUntil") }
    }

    static func markSaved(amount: Int, type: TransactionType, duration: TimeInterval = 2.0) {
        savedFlashAmount = amount
        savedFlashType = type
        savedFlashUntil = Date().addingTimeInterval(duration)
    }

    static func clearSavedFlash() {
        savedFlashAmount = nil
        savedFlashType = nil
        savedFlashUntil = nil
    }
}
