//
//  EditTransactionSheet.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

struct EditTransactionSheet: View {
    @Environment(\.dismiss) private var dismiss

    let transaction: Transaction

    @State private var editType: TransactionType
    @State private var editAmount: String
    @State private var editCategory: Category?
    @State private var editDate: Date
    @State private var editTitle: String

    @FocusState private var isAmountFocused: Bool

    init(transaction: Transaction) {
        self.transaction = transaction
        _editType = State(initialValue: transaction.type)
        _editAmount = State(initialValue: String(transaction.amount))
        _editCategory = State(initialValue: transaction.category)
        _editDate = State(initialValue: transaction.date)
        _editTitle = State(initialValue: transaction.title)
    }

    private var isSaveDisabled: Bool {
        editAmount.isEmpty || editTitle.isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        InputTransactionCard(
                            mode: .edit,
                            transactionType: $editType,
                            amount: $editAmount,
                            selectedCategory: $editCategory,
                            date: $editDate,
                            title: $editTitle,
                            isAmountFocused: $isAmountFocused
                        )
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Edit Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.primary)
                            .frame(width: 30, height: 30)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .disabled(isSaveDisabled)
                    .opacity(isSaveDisabled ? 0.5 : 1.0)
                }
            }
        }
    }

    private func save() {
        transaction.type = editType
        transaction.amount = Int(editAmount) ?? transaction.amount
        if editType == .income {
            transaction.category = .income
        } else {
            let resolvedCategory = editCategory ?? .other
            transaction.category = resolvedCategory == .income ? .other : resolvedCategory
        }
        transaction.date = editDate
        transaction.title = editTitle
    }
}

#Preview {
    let dummy = Transaction(
        type: .expense,
        title: "Makan siang",
        amount: 45_000,
        date: .now,
        category: .fnb
    )
    return EditTransactionSheet(transaction: dummy)
        .modelContainer(for: Transaction.self, inMemory: true)
}
