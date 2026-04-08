//
//  Transaction.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Transaction {
    var id: UUID
    var type: TransactionType
    var title: String
    var amount: Int
    var date: Date
    var category: Category?

    init(
        id: UUID = UUID(),
        type: TransactionType,
        title: String,
        amount: Int,
        date: Date = .now,
        category: Category?
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category
    }
}

enum TransactionType: String, Codable {
    case expense = "Expense"
    case income = "Income"

    var iconBackgroundColor: Color {
        switch self {
        case .income:
            return Color("greenmonny").opacity(0.2)
        case .expense:
            return Color("yellowmonny").opacity(0.2)
        }
    }

    var iconColor: Color {
        switch self {
        case .income:
            return .green
        case .expense:
            return .orange
        }
    }

    var amountColor: Color {
        switch self {
        case .income:
            return Color(red: 0 / 255, green: 180 / 255, blue: 130 / 255)
        case .expense:
            return Color("redicon")
        }
    }
}
