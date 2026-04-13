//
//  TransactionCard.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//
import SwiftData
import SwiftUI

struct AllTransactionCard: View {
    let transaction: Transaction

    private var displayTitle: String {
        let trimmed = transaction.title.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? transaction.type.rawValue : trimmed
    }

    private var displayCategory: Category {
        if transaction.type == .income {
            return .income
        }
        return transaction.category ?? .other
    }

    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: TransactionsDetailView(transaction: transaction)) {
            HStack(spacing: 16) {
                // 1. Ikon Kategori (Dikecilkan agar proporsional)
                ZStack {
                    Circle()
                        .fill(displayCategory.color.opacity(0.15))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: displayCategory.icon)
                        .foregroundColor(displayCategory.color)
                        .font(.system(size: 20, weight: .bold))
                }

                // 2. Judul & Nominal
                VStack(alignment: .leading, spacing: 4) {
                    Text(displayTitle)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text(displayCategory.rawValue)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }

                Spacer()

                // 3. Nominal Uang (Ukuran font dikecilkan agar elegan)
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Rp \(formatAmount(transaction.amount))")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(transaction.type.amountColor)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray.opacity(0.5))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func formatAmount(_ value: Int) -> String {
        Self.currencyFormatter.string(from: NSNumber(value: value)) ?? "0"
    }
}

#Preview {
    NavigationStack {
        VStack {
            AllTransactionCard(transaction: .sampleIncome)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.97))
        .modelContainer(for: Transaction.self, inMemory: true)
    }
}
