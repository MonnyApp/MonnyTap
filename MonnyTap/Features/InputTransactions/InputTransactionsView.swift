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
    // (Tidak masalah diisi default apa saja di sini, karena akan dioverride oleh Card saat onAppear)
    @State private var transactionType: TransactionType = .expense
    @State private var amount: String = ""
    @State private var selectedCategory: Category? = .other
    @State private var date: Date = .now
    @State private var title: String = ""
    
    @FocusState private var isAmountFocused: Bool

    @State private var showAmountAlert: Bool = false

    private var amountInt: Int {
        Int(amount) ?? 0
    }

    private var isAmountValid: Bool {
        amountInt > 0
    }


    var body: some View {
        NavigationStack {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Cukup panggil Card-nya saja. Segmented Control otomatis muncul di dalamnya!
                        InputTransactionCard(
                            mode: .input, // <-- Pastikan mode diset ke input saat menambah data
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
            .alert("Enter an amount", isPresented: $showAmountAlert) {
                Button("OK", role: .cancel) {
                    isAmountFocused = true
                }
            } message: {
                Text("Amount must be greater than Rp 0 before you can save this transaction.")
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAmountFocused = true
            }
        }
    }
    
    // MARK: - Subviews (UI Components)
    
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
                    .background(Color("blueactionbutton").opacity(isAmountValid ? 1 : 0.4))
                    .clipShape(Circle())
            }
        }
    }
    
    // MARK: - Functions
    
    private func saveTransaction() {
        guard isAmountValid else {
            showAmountAlert = true
            return
        }

        var finalCategory: Category
        if transactionType == .income {
            print("DEBUG: Masuk ke blok INCOME") // <--- Tambahkan ini
            finalCategory = .income
        } else {
            print("DEBUG: Masuk ke blok ELSE (Expense)") // <--- Tambahkan ini
            finalCategory = selectedCategory ?? .other
        }
        
        print("DEBUG: Kategori final yang disimpan adalah: \(finalCategory)")
        let newTransaction = Transaction(
            type: transactionType,
            title: title,
            amount: amountInt,
            date: date,
            category: finalCategory
        )
        
        modelContext.insert(newTransaction)
        dismiss()
    }
}

#Preview {
    InputTransactionsView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
