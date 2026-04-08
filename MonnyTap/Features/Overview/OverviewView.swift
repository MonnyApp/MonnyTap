//
//  OverviewView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import Charts

// Warna fallback sementara selama category.color belum diaktifkan
// Hapus extension ini setelah rekam tim aktifkan color di Category.swift
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
    @StateObject private var vm = OverviewViewModel()
    @State private var showAddSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {

            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    BalanceCardSection(vm: vm)
                    AnalyticsSection(vm: vm)
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
    @ObservedObject var vm: OverviewViewModel

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


// MARK: - Analytics (Donut Chart)

private struct AnalyticsSection: View {
    @ObservedObject var vm: OverviewViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Analytics")
                .font(.title2)
                .fontWeight(.bold)

            Chart(vm.analyticsData, id: \.0) { item in
                SectorMark(
                    angle: .value("Persen", item.1),
                    innerRadius: .ratio(0.55),
                    angularInset: 2.5
                )
                // pakai tempColor selama color di Category.swift belum diaktifkan
                .foregroundStyle(item.0.tempColor)
                .cornerRadius(4)
            }
            .frame(height: 220)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 3),
                spacing: 8
            ) {
                ForEach(vm.analyticsData, id: \.0) { item in
                    HStack(spacing: 5) {
                        Circle()
                            // pakai tempColor selama color di Category.swift belum diaktifkan
                            .fill(item.0.tempColor)
                            .frame(width: 8, height: 8)
                        Text("\(item.0.rawValue) \(Int(item.1 * 100))%")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
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
    @ObservedObject var vm: OverviewViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("Recent Transactions")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }

            ForEach(vm.transactions.prefix(5)) { t in
                TransactionRow(transaction: t, vm: vm)
            }
        }
    }
}

private struct TransactionRow: View {
    var transaction: Transaction
    var vm: OverviewViewModel

    var body: some View {
        HStack(spacing: 12) {

            // Ikon kategori dalam lingkaran
            ZStack {
                Circle()
                    .fill(
                        (transaction.category?.tempColor ?? Color("#A0A0A8"))
                            .opacity(0.18)
                    )
                    .frame(width: 50, height: 50)
                Image(systemName: transaction.category?.icon ?? "questionmark")
                    // pakai tempColor selama iconColor di Category.swift belum diaktifkan
                    .foregroundColor(
                        transaction.category?.tempColor ?? Color("#A0A0A8")
                    )
                    .font(.system(size: 18, weight: .medium))
            }

            // Label kategori
            Text(transaction.category?.rawValue ?? "Other")
                .font(.caption2)
                .foregroundColor(.secondary)
                .frame(width: 52)
                .multilineTextAlignment(.center)

            Spacer()

            // Nama transaksi + nominal
            VStack(alignment: .trailing, spacing: 3) {
                Text(transaction.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
                Text(vm.formatRupiah(transaction.amount))
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(
                        transaction.type == .income
                        ? Color("#1D9E75")
                        : Color("#E24B4A")
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 1)
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
            .background(Color("#0F6E56"))
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
        }
        .padding(.bottom, 28)
    }
}


// MARK: - Preview

#Preview {
    OverviewView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
