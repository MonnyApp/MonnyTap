//
//  CategoryListWidgetView.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CategoryListWidgetView: View {
    let entry: MonnyEntry

    private var filteredCategories: [Category] {
        if entry.type == .income {
            return [.income]
        } else {
            return Category.allCases.filter { $0 != .income }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            // MARK: - Header
            HStack {
                Button(intent: BackToMainIntent()) {
                    Image(systemName: "xmark")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Select category")
                    .font(.body)
                    .fontWeight(.semibold)

                Spacer()

                // Invisible spacer to center title
                Image(systemName: "xmark")
                    .font(.body)
                    .opacity(0)
            }

            // MARK: - Category Grid
            let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filteredCategories) { category in
                    Button(intent: SelectCategoryIntent(categoryRaw: category.rawValue)) {
                        VStack(spacing: 6) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(category.color)
                                    .frame(width: 52, height: 52)
                                Image(systemName: category.icon)
                                    .font(.system(size: 22))
                                    .foregroundStyle(.white)
                            }
                            .overlay(
                                entry.selectedCategory == category
                                    ? RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.accentColor, lineWidth: 2.5)
                                    : nil
                            )
                            Text(category.rawValue)
                                .font(.caption2)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 18)
    }
}
