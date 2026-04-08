//
//  ModalCategoryExpenseView.swift
//  MonnyTap
//
//  Created by Ibnu Taufick Ahraza on 07/04/26.
//

import SwiftUI

struct ModalCategoryExpenseView: View {
    // Selected category passed from parent (e.g., a transaction form)
    @Binding var selectedCategory: Category?
    // Optional callback when user taps Save
    var onSave: ((Category?) -> Void)?
    
    @State private var viewModel = ModalCategoryExpenseViewModel()

    @Environment(\.dismiss) private var dismiss

    // Define the 3-column grid layout
    private let columns = [
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
                    ForEach(viewModel.categories) { category in
                        CategoryCell(
                            category: category,
                            isSelected: viewModel.isSelected(category)
                        )
                        .onTapGesture {
                            viewModel.select(category)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.tempSelection = selectedCategory
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

            Button(action: {
                let newValue = viewModel.confirmSelection(currentSelection: selectedCategory)
                selectedCategory = newValue
                onSave?(newValue)
                dismiss()
            }) {
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
    let category: Category
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(category.color.opacity(0.6))
                    .frame(width: 80, height: 80)

                Image(systemName: category.icon)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(category.iconColor)
            }

            Text(category.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6).opacity(0.3))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    @Previewable @State var selected: Category?
    return ModalCategoryExpenseView(selectedCategory: $selected) { _ in }
}
