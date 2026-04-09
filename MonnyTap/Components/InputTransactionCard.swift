//
//  InputTransactionCard.swift
//  MonnyTap
//
//  Created by Ibnu Taufick Ahraza on 09/04/26.
//

import SwiftUI

struct InputTransactionCard: View {
    // MARK: - Bindings (Connected to Parent View)
    @Binding var transactionType: TransactionType
    @Binding var amount: String
    @Binding var selectedCategory: Category?
    @Binding var date: Date
    @Binding var title: String
    
    var body: some View {
        VStack(spacing: 16) {
            amountInputView
            
            // Only show category if it's an expense
            if transactionType == .expense {
                categoryRowView
            }
            
            dateRowView
            nameRowView
        }
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(24)
        .padding(.horizontal)
    }
    
    // MARK: - Subviews
    
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
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
    
    private var categoryRowView: some View {
        NavigationLink {
            // This works perfectly because the parent view has the NavigationStack!
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
}

// MARK: - Preview
#Preview {
    // We use .constant() just to provide dummy data for the Canvas preview
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        InputTransactionCard(
            transactionType: .constant(.expense),
            amount: .constant("150000"),
            selectedCategory: .constant(.fnb),
            date: .constant(.now),
            title: .constant("Lunch")
        )
    }
}
