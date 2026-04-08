//
//  ModalCategoryExpenseView.swift
//  MonnyTap
//
//  Created by Ibnu Taufick Ahraza on 07/04/26.
//

import SwiftUI

struct ExpenseCategory: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String // SF Symbols or Custom
    let color: Color
}

struct ModalCategoryExpenseView: View {
    // This will eventually be moved to a @StateObject ViewModel
    let categories: [ExpenseCategory] = [
        ExpenseCategory(name: "FnB", iconName: "fork.knife", color: .yellow),
        ExpenseCategory(name: "Investment", iconName: "house.fill", color: .orange),
        ExpenseCategory(name: "Education", iconName: "graduationcap.fill", color: .blue),
        ExpenseCategory(name: "Shopping", iconName: "bag.fill", color: .pink),
        ExpenseCategory(name: "Entertainment", iconName: "gamecontroller.fill", color: .purple),
        ExpenseCategory(name: "Health", iconName: "heart.fill", color: .red),
        ExpenseCategory(name: "Travels", iconName: "figure.walk", color: .brown),
        ExpenseCategory(name: "Transportation", iconName: "car.fill", color: .cyan),
        ExpenseCategory(name: "Other", iconName: "circle.fill", color: .gray)
    ]
    
    @State private var selectedCategoryId: UUID? = nil
    @Environment(\.dismiss) var dismiss

    // Define the 3-column grid layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(categories) { category in
                        CategoryCell(
                            category: category,
                            isSelected: selectedCategoryId == category.id
                        )
                        .onTapGesture {
                            selectedCategoryId = category.id
                        }
                    }
                }
                .padding()
            }
        }
    }

    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            
            Spacer()
            
            Text("Choose Category")
                .font(.headline)
            
            Spacer()
            
            Button(action: { /* Save Logic */ }) {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}

struct CategoryCell: View {
    let category: ExpenseCategory
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(category.color.opacity(0.6))
                    .frame(width: 80, height: 80)
                
                Image(systemName: category.iconName)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
            }
            
            Text(category.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6).opacity(0.3))
        .cornerRadius(20)
        // Add a subtle border if selected
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    ModalCategoryExpenseView()
}
