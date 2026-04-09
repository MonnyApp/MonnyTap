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
    @State private var selectedCategory: Category? = .other
    @State private var date: Date = .now
    @State private var title: String = ""
    
    // MARK: - Main Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Background layar paling dasar (bisa putih atau abu-abu sangat terang)
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // 1. Segmented Control di luar card
                        transactionTypePicker
                        
                        // 2. Card besar abu-abu yang membungkus semua input form
                        inputFormCard
                        
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
    }
    
    // MARK: - Subviews (UI Components)
    
    /// Variabel terpisah untuk Segmented Control
    private var transactionTypePicker: some View {
        Picker("Transaction Type", selection: $transactionType) {
            Text("Expense").tag(TransactionType.expense)
            Text("Income").tag(TransactionType.income)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    /// Variabel terpisah untuk isi Toolbar
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
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .disabled(amount.isEmpty || title.isEmpty)
            .opacity((amount.isEmpty || title.isEmpty) ? 0.5 : 1.0)
        }
    }
    
    /// Card pembungkus utama berwarna abu-abu
    private var inputFormCard: some View {
        VStack(spacing: 16) { // Jarak antar card putih di dalamnya
            amountInputView
            if transactionType == .expense {
                categoryRowView
            }
            dateRowView
            nameRowView
        }
        .padding(16) // Padding di dalam card abu-abu
        .background(Color(.systemGray6)) // Warna abu-abu untuk card pembungkus
        .cornerRadius(24) // Lengkungan card pembungkus
        .padding(.horizontal) // Jarak card pembungkus dari tepi layar
    }
    
    /// Card Putih: Input Nominal
    private var amountInputView: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Rp")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
                
                TextField("0", text: $amount)
                    .font(.system(size: 40, weight: .bold))
                    .keyboardType(.numberPad)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
        .background(Color(UIColor.secondarySystemGroupedBackground)) // Warna Putih
        .cornerRadius(16)
    }
    
    /// Card Putih: Pilihan Kategori
    private var categoryRowView: some View {
        NavigationLink {
            ModalCategoryExpenseView(selectedCategory: $selectedCategory)
        } label: {
            HStack {
                ZStack {
                    Circle()
                        .fill(selectedCategory?.color ?? Color.gray.opacity(0.5))
                        .frame(width: 32, height: 32)
                    
                    if let category = selectedCategory {
                        Image(systemName: category.icon)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(category.iconColor)
                    }
                }
                
                Text(selectedCategory?.rawValue ?? "Category")
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    /// Card Putih: Pilihan Tanggal
    private var dateRowView: some View {
        HStack {
            Text("Date")
                .font(.body)
            Spacer()
            DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
    
    /// Card Putih: Input Nama
    private var nameRowView: some View {
        HStack {
            Text("Name")
                .font(.body)
                .frame(width: 60, alignment: .leading)
            
            TextField("", text: $title)
                .font(.body)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
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
