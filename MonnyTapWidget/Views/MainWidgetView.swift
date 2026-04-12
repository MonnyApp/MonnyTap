//
//  MainWidgetView.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import SwiftUI
import WidgetKit

struct MainWidgetView: View {
    let entry: MonnyEntry

    var body: some View {
        VStack(spacing: 6) {
            // MARK: - Segmented Control
            HStack(spacing: 8) {
                Button(intent: SetTypeIntent(typeRaw: "Expense")) {
                    Text("Expense")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(entry.type == .expense ? Color.red.opacity(0.2) : Color.clear)
                        .foregroundStyle(entry.type == .expense ? Color.red : Color.secondary)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)

                Button(intent: SetTypeIntent(typeRaw: "Income")) {
                    Text("Income")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(entry.type == .income ? Color.green.opacity(0.2) : Color.clear)
                        .foregroundStyle(entry.type == .income ? Color.green : Color.secondary)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 4)

            // MARK: - Category Row
            HStack(spacing: 8) {
                ForEach(entry.topCategories) { category in
                    Button(intent: SelectCategoryIntent(categoryRaw: category.rawValue)) {
                        VStack(spacing: 2) {
                            ZStack {
                                Circle()
                                    .fill(category.color.opacity(0.3))
                                    .frame(width: 28, height: 28)
                                Image(systemName: category.icon)
                                    .font(.system(size: 12))
                                    .foregroundStyle(category.iconColor)
                            }
                            Text(category.rawValue)
                                .font(.system(size: 8))
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                    .overlay(
                        entry.selectedCategory == category
                            ? RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.accentColor, lineWidth: 1.5)
                            : nil
                    )
                }

                Button(intent: ShowCategoryListIntent()) {
                    VStack(spacing: 2) {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                        Text("More")
                            .font(.system(size: 8))
                            .lineLimit(1)
                    }
                }
                .buttonStyle(.plain)
            }

            // MARK: - Amount Display
            HStack(spacing: 4) {
                Text("Rp")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(formattedAmount)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 8)

            // MARK: - Calculator Grid
            let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 4)

            LazyVGrid(columns: columns, spacing: 4) {
                digitButton("1")
                digitButton("2")
                digitButton("3")
                actionButton("delete.left", intent: BackspaceIntent())

                digitButton("4")
                digitButton("5")
                digitButton("6")
                actionButton("AC", intent: ClearIntent(), isText: true)

                digitButton("7")
                digitButton("8")
                digitButton("9")
                saveButton

                digitButton("000")
                digitButton("0")
                digitButton(".")
                Color.clear
            }
        }
        .padding(8)
    }

    // MARK: - Helpers

    private var formattedAmount: String {
        if entry.amountDraft.isEmpty { return "0" }
        guard let number = Int(entry.amountDraft) else { return entry.amountDraft }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: number)) ?? entry.amountDraft
    }

    private func digitButton(_ digit: String) -> some View {
        Button(intent: AppendDigitIntent(digit: digit)) {
            Text(digit)
                .font(.caption)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(.plain)
    }

    private func actionButton(_ label: String, intent: some AppIntent, isText: Bool = false) -> some View {
        Button(intent: intent) {
            Group {
                if isText {
                    Text(label)
                        .font(.caption)
                        .fontWeight(.medium)
                } else {
                    Image(systemName: label)
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray4))
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(.plain)
    }

    private var saveButton: some View {
        Button(intent: SaveTransactionIntent()) {
            Image(systemName: "checkmark")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(.plain)
    }
}
