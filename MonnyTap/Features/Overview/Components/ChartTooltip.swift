//
//  ChartTooltip.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 08/04/26.
//

import SwiftUI

enum TooltipCorner {
    case topLeading, topTrailing, bottomLeading, bottomTrailing
}

struct ChartTooltip: View {
    let categoryName: String
    let value: String
    let sharpCorner: TooltipCorner

    private let sharpRadius: CGFloat = 4
    private let smoothRadius: CGFloat = 16

    private func radius(for corner: TooltipCorner) -> CGFloat {
        corner == sharpCorner ? sharpRadius : smoothRadius
    }

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
                topLeadingRadius: radius(for: .topLeading),
                bottomLeadingRadius: radius(for: .bottomLeading),
                bottomTrailingRadius: radius(for: .bottomTrailing),
                topTrailingRadius: radius(for: .topTrailing)
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
        sharpCorner: .topTrailing
    )
}
