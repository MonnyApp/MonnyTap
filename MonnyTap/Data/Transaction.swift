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
    var type: String
    var title: String
    var amount: Decimal
    var date: Date
    var category: Category?

    init(
        id: UUID = UUID(),
        type: TransactionType,
        title: String,
        amount: Decimal,
        date: Date = .now,
        category: Category? = nil
    ) {
        self.id = id
        self.type = type.rawValue
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category?.rawValue
    }
}

enum TransactionType: String {
    case expense = "Expense"
    case income = "Income"
}
