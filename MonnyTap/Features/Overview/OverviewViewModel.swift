//
//  OverviewViewModel.swift
//  MonnyTap
//
//  Created by Ivone Liwang on 08/04/26.
//

import Foundation
import SwiftUI
import Combine

class OverviewViewModel: ObservableObject {

    // MARK: - Data (semua dari MockData untuk sekarang)

    @Published var transactions: [Transaction]       = MockData.transactions
    @Published var analyticsData: [(Category, Double)] = MockData.analyticsData

    var balance: Int    { MockData.balance }
    var income:  Int    { MockData.income  }
    var expense: Int    { MockData.expense }
    var month:   String { MockData.month   }

    // MARK: - Aksi

    func addTransaction(_ t: Transaction) {
        transactions.insert(t, at: 0)
    }

    // MARK: - Format Rupiah
    // Contoh: 5000000 → "Rp 5.000.000"

    func formatRupiah(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.groupingSeparator     = "."
        formatter.decimalSeparator      = ","
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: amount)) ?? "0"
        return "Rp \(result)"
    }
}
