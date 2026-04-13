//
//  OverviewView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import Charts
import SwiftData
import SwiftUI

struct OverviewView: View {
    @State private var vm = OverviewViewModel()
    @State private var showAddSheet = false

    // Sama persis seperti TransactionsView — fetch langsung dari SwiftData
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        BalanceCardSection(vm: vm)
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Analytics")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom,30)
                            AnalyticsChartView(viewModel: vm)
                                .frame(maxWidth: .infinity)
                                .padding(30)
                        }
                        .padding(.vertical, 16)
                        RecentTransactionsSection(vm: vm)
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .background(
                        GeometryReader { geo in
                            Image("Image")
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geo.size.width,
                                    height: max(0, geo.frame(in: .global).minY + 130)
                                )
                                .clipped()
                                .offset(y: -geo.frame(in: .global).minY)
                        }
                    )
                }

                AddTransactionFAB {
                    showAddSheet = true
                }
            }
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showAddSheet) {
                InputTransactionsView()
            }
            // Saat view pertama muncul, kirim data ke ViewModel
            .onAppear {
                vm.update(with: transactions)
            }
            // Setiap kali SwiftData update (transaksi baru/hapus),
            // kirim data terbaru ke ViewModel — sama seperti pola TransactionsView
            .onChange(of: transactions) { _, newTransactions in
                vm.update(with: newTransactions)
            }
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

            Text(vm.formatRupiah(vm.balance))
                .font(.title2)
                .fontWeight(.bold)

            Divider()

            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(Color("greenincome"))
                Text("Income")
                    .foregroundColor(Color("greenincome"))
                    .font(.subheadline)
                Spacer()
                Text(vm.formatRupiah(vm.income))
                    .foregroundColor(Color("greenincome"))
                    .fontWeight(.semibold)
            }

            HStack {
                Image(systemName: "chart.line.downtrend.xyaxis")
                    .foregroundColor(Color("redexpense"))
                Text("Expense")
                    .foregroundColor(Color("redexpense"))
                    .font(.subheadline)
                Spacer()
                Text(vm.formatRupiah(vm.expense))
                    .foregroundColor(Color("redexpense"))
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
            NavigationLink(destination: TransactionsView()) {
                HStack {
                    Text("Recent Transactions")
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .foregroundColor(.primary)

            ForEach(vm.transactions.prefix(5)) { t in
                TransactionCard(transaction: t)
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
private struct OverviewViewPreview: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [Transaction]

    var body: some View {
        OverviewView()
            .onAppear {
                if transactions.isEmpty {
                    for transaction in MockData.transactions {
                        modelContext.insert(transaction)
                    }
                }
            }
    }
}

#Preview {
    OverviewViewPreview()
        .modelContainer(for: Transaction.self, inMemory: true)
}
