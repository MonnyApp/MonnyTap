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

    @State private var editType: TransactionType = .expense
    @State private var editAmount: String = ""
    @State private var editCategory: Category? = nil
    @State private var editDate: Date = .now
    @State private var editTitle: String = ""
    
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
                        editType = transaction.type
                        editAmount = String(transaction.amount)
                        editCategory = transaction.category
                        editDate = transaction.date
                        editTitle = transaction.title
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
            Text("Are you sure you want to delete \"\(transaction.title)\" Transactions?.")
        }
        .sheet(isPresented: $showEditSheet) {
            NavigationStack {
                ZStack {
                    Color(.systemBackground).ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 24) {
                            Picker("Transaction Type", selection: $editType) {
                                Text("Expense").tag(TransactionType.expense)
                                Text("Income").tag(TransactionType.income)
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal)

                            InputTransactionCard(
                                mode: .edit,
                                transactionType: $editType,
                                amount: $editAmount,
                                selectedCategory: $editCategory,
                                date: $editDate,
                                title: $editTitle,
                                isAmountFocused: $isAmountFocused
                            )
                        }
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Edit Transaction")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button { showEditSheet = false } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.primary)
                                .frame(width: 30, height: 30)
                                .background(Color(.systemGray5))
                                .clipShape(Circle())
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            transaction.type = editType
                            transaction.amount = Int(editAmount) ?? transaction.amount
                            transaction.category = editCategory
                            transaction.date = editDate
                            transaction.title = editTitle
                            showEditSheet = false
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                        .disabled(editAmount.isEmpty || editTitle.isEmpty)
                        .opacity((editAmount.isEmpty || editTitle.isEmpty) ? 0.5 : 1.0)
                    }
                }
            }
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
