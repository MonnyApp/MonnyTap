//
//  OverviewView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import Charts
import SwiftData

private extension Category {
    var tempColor: Color {
        switch self {
        case .fnb:            return Color("yellowmonny")
        case .investment:     return Color("orangemonny")
        case .education:      return Color("bluemonny")
        case .shopping:       return Color("pinkmonny")
        case .entertainment:  return Color("purplemonny")
        case .health:         return Color("redmonny")
        case .travels:        return Color("Chocomonny")
        case .transportation: return Color("toscamonny")
        case .other:          return Color("greymonny")
        }
    }
}

struct OverviewView: View {
    @State private var vm = OverviewViewModel()
    @State private var showAddSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {

            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    BalanceCardSection(vm: vm)
                    AnalyticsChartView(viewModel: vm)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 16)
                        .padding(.top, 16)
                    RecentTransactionsSection(vm: vm)
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }

            AddTransactionFAB {
                showAddSheet = true
            }
        }
        .navigationTitle("Overview")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddSheet) {
            Text("Form tambah transaksi — coming soon")
                .font(.title3)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}


// MARK: - Balance Card

private struct BalanceCardSection: View {
    @Bindable var vm: OverviewViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Text("Balance")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Spacer()
                Text(vm.month)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }

            Text("\(vm.formatRupiah(vm.balance))")
                .font(.title2)
                .fontWeight(.bold)

            Divider()

            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(Color("#1D9E75"))
                Text("Income")
                    .foregroundColor(Color("#1D9E75"))
                    .font(.subheadline)
                Spacer()
                Text(vm.formatRupiah(vm.income))
                    .foregroundColor(Color("#1D9E75"))
                    .fontWeight(.semibold)
            }

            HStack {
                Image(systemName: "chart.line.downtrend.xyaxis")
                    .foregroundColor(Color("#E24B4A"))
                Text("Expense")
                    .foregroundColor(Color("#E24B4A"))
                    .font(.subheadline)
                Spacer()
                Text(vm.formatRupiah(vm.expense))
                    .foregroundColor(Color("#E24B4A"))
                    .fontWeight(.semibold)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 2)
    }
}




// MARK: - Recent Transactions

private struct RecentTransactionsSection: View {
    @Bindable var vm: OverviewViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("Recent Transactions")
                    .font(.title2)
                    .fontWeight(.bold)
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }

            ForEach(vm.transactions.prefix(5)) { t in
                TransactionCard()
            }
        }
    }
}

// MARK: - FAB Button

private struct AddTransactionFAB: View {
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                Text("Add Transaction")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 36)
            .padding(.vertical, 16)
            .background(Color("blueactionbutton"))
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
        }
        .padding(.bottom, 2)
    }
}


// MARK: - Preview
#Preview {
    NavigationStack {
        OverviewView()
            .modelContainer(for: Transaction.self, inMemory: true)
    }
}
