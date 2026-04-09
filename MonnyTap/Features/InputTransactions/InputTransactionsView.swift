//
//  InputTransactionsView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

struct InputTransactionsView: View {
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    // MARK: - State Variables
    @State private var transactionType: TransactionType = .expense
    @State private var amount: String = ""
    @State private var selectedCategory: Category? = .other // Default is .other
    @State private var date: Date = .now
    @State private var title: String = ""
    // MARK: - Focus state
    @FocusState private var isAmountFocused: Bool
    
    // MARK: - Main Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // 1. The Segmented Control
                        transactionTypePicker
                        
                        // 2. The Reusable Card Component
                        // We pass our @State variables down using the '$' prefix to create Bindings
                        InputTransactionCard(
                            transactionType: $transactionType,
                            amount: $amount,
                            selectedCategory: $selectedCategory,
                            date: $date,
                            title: $title,
                            isAmountFocused: $isAmountFocused
                        )
                        
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAmountFocused = true
            }
        }
    }
    
    // MARK: - Subviews (UI Components)
    
    private var transactionTypePicker: some View {
        Picker("Transaction Type", selection: $transactionType) {
            Text("Expense").tag(TransactionType.expense)
            Text("Income").tag(TransactionType.income)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    @ToolbarContentBuilder
    private var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(width: 30, height: 30)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: saveTransaction) {
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Color("blueactionbutton"))
                    .clipShape(Circle())
            }
        }
    }
    
    // MARK: - Functions
    
    private func saveTransaction() {
        let amountInt = Int(amount) ?? 0
        let newTransaction = Transaction(
            type: transactionType,
            title: title,
            amount: amountInt,
            date: date,
            category: selectedCategory ?? .other
        )
        
        modelContext.insert(newTransaction)
        dismiss()
    }
}

#Preview {
    InputTransactionsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
