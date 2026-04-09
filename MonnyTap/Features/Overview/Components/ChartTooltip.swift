//
//  ChartTooltip.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 08/04/26.
//

import SwiftUI

struct ChartTooltip: View {
    let categoryName: String
    let value: String
    let isLeftSide: Bool

    private let sharpRadius: CGFloat = 4
    private let smoothRadius: CGFloat = 16

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(categoryName)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(value)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: isLeftSide ? sharpRadius : smoothRadius,
                bottomLeadingRadius: isLeftSide ? sharpRadius : smoothRadius,
                bottomTrailingRadius: isLeftSide ? smoothRadius : sharpRadius,
                topTrailingRadius: isLeftSide ? smoothRadius : sharpRadius
            )
            .fill(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        )
    }
}

#Preview {
    ChartTooltip(
        categoryName: "Other",
        value: "Rp. 50.000",
        isLeftSide: false
    )
}
