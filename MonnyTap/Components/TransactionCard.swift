//
//  TransactionCard.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

struct TransactionCard: View {
    let transaction: Transaction

    var body: some View {
        NavigationLink(destination: TransactionsDetailView(transaction: transaction)) {
            HStack(alignment: .center, spacing: 16) {

                // Ikon + label kategori
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(transaction.category?.color ?? Color.gray.opacity(0.5))
                            .frame(width: 40, height: 40)
                        Image(systemName: transaction.category?.icon ?? "creditcard")
                            .foregroundColor(transaction.category?.iconColor ?? .white)
                            .font(.system(size: 20))
                    }
                    Text(transaction.category?.rawValue ?? "Other")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .frame(width: 70)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 70) // lebar tetap agar semua card seragam

                Spacer()

                // Judul + nominal (rata kanan)
                VStack(alignment: .trailing, spacing: 4) {
                    Text(transaction.title)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.trailing)
                    Text("Rp \(transaction.amount.formatted())")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            transaction.type == .expense
                            ? Color("redexpense")
                            : Color("greenincome")
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    let dummy = Transaction(
        type: .expense,
        title: "Ayam Geprek Wani",
        amount: 13_000,
        date: .now,
        category: .fnb
    )
    NavigationStack {
        TransactionCard(transaction: dummy)
    }
    .modelContainer(for: Transaction.self, inMemory: true)
}
