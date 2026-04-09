//
//  TransactionCard.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftData
import SwiftUI

struct AllTransactionCard: View {
    /// Kita menerima objek Transaction utuh dari model
    let transaction: Transaction

    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: TransactionsDetailView(transaction: transaction)) {
            HStack(spacing: 12) {
                // Sisi Kiri: Ikon Kategori dari Enum
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(transaction.type.iconBackgroundColor)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: transaction.category?.icon ?? "questionmark")
                            .foregroundColor(transaction.type.iconColor)
                            .font(.system(size: 16))
                    }
                    
                    Text(transaction.category?.rawValue ?? "Other")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }
                
                // Sisi Tengah: Judul & Nominal
                VStack(alignment: .leading, spacing: 2) {
                    Text(transaction.title)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Text("Rp \(formatAmount(transaction.amount))")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(transaction.type.amountColor)
                }
                
                Spacer()
                
                // Sisi Kanan: Button Chevron (Hanya Visual)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(8)
                    .background(Circle().fill(Color.gray.opacity(0.1)))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
            )
        }
    }
    
    /// Fungsi pembantu format rupiah
    private func formatAmount(_ value: Int) -> String {
        Self.currencyFormatter.string(from: NSNumber(value: value)) ?? "0"
    }
}

#Preview {
    NavigationStack {
        AllTransactionCard(transaction: .sampleIncome)
            .padding()
            .background(Color.gray.opacity(0.1)) // Agar capsule putih terlihat jelas
            .modelContainer(for: Transaction.self, inMemory: true)
    }
}
