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
        VStack(spacing: 10) {
            // MARK: - Segmented Control
            HStack(spacing: 0) {
                Button(intent: SetTypeIntent(typeRaw: "Expense")) {
                    Text("Expense")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(entry.type == .expense ? Color.red.opacity(0.2) : Color.clear)
                        .foregroundStyle(entry.type == .expense ? Color.red : Color.secondary)
                }
                .buttonStyle(.plain)

                Button(intent: SetTypeIntent(typeRaw: "Income")) {
                    Text("Income")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(entry.type == .income ? Color.green.opacity(0.2) : Color.clear)
                        .foregroundStyle(entry.type == .income ? Color.green : Color.secondary)
                }
                .buttonStyle(.plain)
            }
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.secondary.opacity(0.3), lineWidth: 1))

            // MARK: - Category Row (hidden for income)
            if entry.type == .expense {
                HStack {
                    ForEach(entry.topCategories) { category in
                    Button(intent: SelectCategoryIntent(categoryRaw: category.rawValue)) {
                        VStack(spacing: 4) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(category.color)
                                    .frame(width: 44, height: 44)
                                Image(systemName: category.icon)
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                            }
                            .overlay(
                                entry.selectedCategory == category
                                    ? RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.accentColor, lineWidth: 2.5)
                                    : nil
                            )
                            Text(category.rawValue)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }

                Button(intent: ShowCategoryListIntent()) {
                    VStack(spacing: 4) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 44, height: 44)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18))
                                .foregroundStyle(.secondary)
                        }
                        Text("See more")
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
            }

            // MARK: - Amount Display / Saved Flash
            if let flash = entry.savedFlash {
                HStack(spacing: 6) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(flash.type == .income ? .green : .red)
                    Text("Saved \(currencySymbol) \(formattedAmount(flash.amount))")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill((flash.type == .income ? Color.green : Color.red).opacity(0.15))
                )
            } else if let errorMessage = entry.errorFlash {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.orange)
                    Text(errorMessage)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange.opacity(0.15))
                )
            } else {
                HStack {
                    Text(currencySymbol)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(formattedNumber)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .contentTransition(.identity)
                        .animation(nil, value: entry.amountDraft)
                }
            }

            // MARK: - Calculator Grid
            HStack(spacing: 6) {
                // Left: 3-column digit grid
                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        digitButton("7")
                        digitButton("8")
                        digitButton("9")
                    }
                    HStack(spacing: 6) {
                        digitButton("4")
                        digitButton("5")
                        digitButton("6")
                    }
                    HStack(spacing: 6) {
                        digitButton("1")
                        digitButton("2")
                        digitButton("3")
                    }
                    HStack(spacing: 6) {
                        digitButton("000")
                        digitButton("0")
                        acButton
                    }
                }

                // Right: 2 tall buttons
                VStack(spacing: 6) {
                    Button(intent: BackspaceIntent()) {
                        Image(systemName: "delete.left")
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemGray4))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)

                    Button(intent: SaveTransactionIntent()) {
                        Text("Save")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
                .frame(width: 70)
            }
        }
        .padding(.vertical, 18)
    }

    // MARK: - Helpers

    private var currencySymbol: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        return formatter.currencySymbol ?? "Rp"
    }

    private var formattedNumber: String {
        formattedAmount(Int(entry.amountDraft) ?? 0)
    }

    private func formattedAmount(_ amount: Int) -> String {
        amount.formatted(.number.locale(Locale(identifier: "id_ID")))
    }

    private func digitButton(_ digit: String) -> some View {
        Button(intent: AppendDigitIntent(digit: digit)) {
            Text(digit)
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }

    private var acButton: some View {
        Button(intent: ClearIntent()) {
            Text("AC")
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color(.systemGray4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}
