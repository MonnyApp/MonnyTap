//
//  TransactionsDetailView.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

struct TransactionsDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let transaction: Transaction

    @State private var showEditSheet = false
    @State private var showDeleteAlert = false

    @FocusState private var isAmountFocused: Bool

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    typeIndicator
                    InputTransactionCard(
                        mode: .detail,
                        transactionType: .constant(transaction.type),
                        amount: .constant(transaction.amount.formatted()),
                        selectedCategory: .constant(transaction.category),
                        date: .constant(transaction.date),
                        title: .constant(transaction.title),
                        isAmountFocused: $isAmountFocused
                    )
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Detail Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        showEditSheet = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .alert("Delete This Item", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                modelContext.delete(transaction)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this transactions?.")
        }
        .sheet(isPresented: $showEditSheet) {
            EditTransactionSheet(transaction: transaction)
        }
    }
    
    // MARK: - Subviews
    
    private var typeIndicator: some View {
        Text(transaction.type.rawValue)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .shadow(radius: 1)
    }
}

#Preview {
    let dummy = Transaction(
        type: .expense,
        title: "Makan siang",
        amount: 45_000,
        date: .now,
        category: .fnb
    )
    NavigationStack {
        TransactionsDetailView(transaction: dummy)
    }
    .modelContainer(for: Transaction.self, inMemory: true)
}
