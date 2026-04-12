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
        VStack(spacing: 8) {
            // MARK: - Header
            HStack {
                Text("Select Category")
                    .font(.caption)
                    .fontWeight(.semibold)
                Spacer()
                Button(intent: BackToMainIntent()) {
                    Image(systemName: "xmark")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 4)

            // MARK: - Category Grid
            let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 4)

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(filteredCategories) { category in
                    Button(intent: SelectCategoryIntent(categoryRaw: category.rawValue)) {
                        VStack(spacing: 4) {
                            ZStack {
                                Circle()
                                    .fill(category.color.opacity(0.3))
                                    .frame(width: 32, height: 32)
                                Image(systemName: category.icon)
                                    .font(.system(size: 14))
                                    .foregroundStyle(category.iconColor)
                            }
                            Text(category.rawValue)
                                .font(.system(size: 9))
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }

            Spacer()
        }
        .padding(8)
    }
}
