//
//  InputTransactionCard.swift
//  MonnyTap
//
//  Created by Ibnu Taufick Ahraza on 09/04/26.
//

import SwiftUI

enum CardMode {
    case input
    case edit
    case detail
}

struct InputTransactionCard: View {
    // MARK: - Mode
    var mode: CardMode = .input

    // MARK: - Bindings (Connected to Parent View)
    @Binding var transactionType: TransactionType
    @Binding var amount: String
    @Binding var selectedCategory: Category?
    @Binding var date: Date
    @Binding var title: String

    private var isEditable: Bool { mode != .detail }
    
    var isAmountFocused: FocusState<Bool>.Binding

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

                if isEditable {
                    TextField("0", text: $amount)
                        .font(.system(size: 40, weight: .bold))
                        .keyboardType(.numberPad)
                        .focused(isAmountFocused)
                } else {
                    Text(amount)
                        .font(.system(size: 40, weight: .bold))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }

    @ViewBuilder
    private var categoryRowView: some View {
        if isEditable {
            NavigationLink {
                ModalCategoryExpenseView(selectedCategory: $selectedCategory)
            } label: {
                HStack {
                    categoryIconAndLabel
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
        } else {
            HStack {
                categoryIconAndLabel
                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
        }
    }

    private var categoryIconAndLabel: some View {
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
        }
    }

    private var dateRowView: some View {
        HStack {
            Text("Date")
                .font(.body)
            Spacer()
            if isEditable {
                DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
            } else {
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
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

            if isEditable {
                TextField("", text: $title)
                    .font(.body)
            } else {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @FocusState private var isAmountFocused: Bool

        var body: some View {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                VStack(spacing: 24) {
                    InputTransactionCard(
                        mode: .input,
                        transactionType: .constant(.expense),
                        amount: .constant("150000"),
                        selectedCategory: .constant(.fnb),
                        date: .constant(.now),
                        title: .constant(""),
                        isAmountFocused: $isAmountFocused
                    )
                    InputTransactionCard(
                        mode: .detail,
                        transactionType: .constant(.expense),
                        amount: .constant("150000"),
                        selectedCategory: .constant(.fnb),
                        date: .constant(.now),
                        title: .constant("Lunch"),
                        isAmountFocused: $isAmountFocused
                    )
                }
            }
        }
    }
    return PreviewWrapper()
}
