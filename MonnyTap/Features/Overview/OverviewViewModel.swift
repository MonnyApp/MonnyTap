//
//  OverviewViewModel.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 08/04/26.
//

import Foundation

@Observable
class OverviewViewModel {
    var chartData: [ChartDataPoint] = []

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
            point.endAngle = cursor + pct
            cursor += pct
            result.append(point)
        }

        chartData = result
    }
}

