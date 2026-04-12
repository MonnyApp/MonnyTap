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
        VStack(spacing: 12) {
            // MARK: - Header
            HStack {
                Text("Select Category")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Button(intent: BackToMainIntent()) {
                    Image(systemName: "xmark")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }

            // MARK: - Category Grid
            let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(filteredCategories) { category in
                    Button(intent: SelectCategoryIntent(categoryRaw: category.rawValue)) {
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(category.color.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                Image(systemName: category.icon)
                                    .font(.system(size: 18))
                                    .foregroundStyle(category.iconColor)
                            }
                            Text(category.rawValue)
                                .font(.system(size: 12))
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }

            Spacer()
        }
        .padding(12)
    }
}
