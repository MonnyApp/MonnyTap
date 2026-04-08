//
//  Transaction.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import Foundation
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
        category: Category?     ) {
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
}
