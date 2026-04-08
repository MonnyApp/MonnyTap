//
//  OverviewView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

struct OverviewView: View {
    @Query private var transactions: [Transaction]
    
    @State private var viewModel = OverviewViewModel()

    var body: some View {
        AnalyticsChartView(viewModel: viewModel)
            .onAppear {
                viewModel.loadChartData(from: transactions)
            }
            .onChange(of: transactions) {
                viewModel.loadChartData(from: transactions)
            }
    }
}

#Preview {
    OverviewView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
