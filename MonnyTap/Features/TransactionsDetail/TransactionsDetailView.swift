//
//  TransactionsDetailView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

struct TransactionsDetailView: View {
    let transaction: Transaction

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    typeIndicator
                    InputTransactionCard(
                        mode: .detail,
                        transactionType: .constant(transaction.type),
                        amount: .constant(transaction.amount.formatted()),
                        selectedCategory: .constant(transaction.category),
                        date: .constant(transaction.date),
                        title: .constant(transaction.title)
                    )
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Detail Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    /// Read-only type label styled like a segmented control
    private var typeIndicator: some View {
        Text(transaction.type.rawValue)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(Capsule())
            .padding(.horizontal)
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
    NavigationStack {
        TransactionsDetailView(transaction: dummy)
    }
    .modelContainer(for: Transaction.self, inMemory: true)
}
