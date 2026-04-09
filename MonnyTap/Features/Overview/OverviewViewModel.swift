//
//  OverviewViewModel.swift
//  MonnyTap
//
//  Created by Ivone Liwang on 08/04/26.
//

import Foundation
import SwiftUI

@Observable
class OverviewViewModel {

    // MARK: - Data
    var chartData: [ChartDataPoint] = []
    var transactions: [Transaction] = MockData.transactions

    var balance: Int    { MockData.balance }
    var income:  Int    { MockData.income  }
    var expense: Int    { MockData.expense }
    var month:   String { MockData.month   }

    // MARK: - Init
    // loadChartData dipanggil otomatis begitu ViewModel dibuat
    init() {
        loadChartData(from: MockData.transactions)
    }

    // MARK: - Aksi

    func addTransaction(_ t: Transaction) {
        transactions.insert(t, at: 0)
        loadChartData(from: transactions) // chart ikut update saat ada transaksi baru
    }

    // MARK: - Chart Logic

    func loadChartData(from transactions: [Transaction]) {
        let expenses = transactions.filter { $0.type == .expense && $0.category != nil }

        let grouped = Dictionary(grouping: expenses, by: { $0.category! })
        let categoryTotals = grouped.map { (category, txns) in
            (category, txns.reduce(0) { $0 + $1.amount })
        }
        .sorted { $0.1 > $1.1 }

        let total = categoryTotals.reduce(0) { $0 + $1.1 }
        guard total > 0 else {
            chartData = []
            return
        }

        var result: [ChartDataPoint] = []
        var cursor: Double = 0

        for (category, amount) in categoryTotals {
            let pct = Double(amount) / Double(total)
            var point = ChartDataPoint(
                category: category,
                amount: Double(amount),
                percentage: pct
            )
            point.startAngle = cursor
            point.endAngle   = cursor + pct
            cursor          += pct
            result.append(point)
        }

        chartData = result
    }

    // MARK: - Format Rupiah

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
