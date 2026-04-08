//
//  AnalyticsChart.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 08/04/26.
//

import SwiftUI

/// Data Model
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let category: Category
    let percentage: Double

    var startAngle: Double = 0
    var endAngle: Double = 0
}

// Hardcoded Mock Data ( nanti diganti swiftData)
extension ChartDataPoint {
    static let mockData: [ChartDataPoint] = {
        let raw: [(Category, Double)] = [
            (.investment, 0.30),
            (.education, 0.12),
            (.health, 0.11),
            (.shopping, 0.10),
            (.entertainment, 0.04),
            (.travels, 0.06),
            (.transportation, 0.04),
            (.other, 0.15),
            (.fnb, 0.08),
        ]

        var result: [ChartDataPoint] = []
        var cursor: Double = 0

        for (category, pct) in raw {
            var point = ChartDataPoint(category: category, percentage: pct)
            point.startAngle = cursor
            point.endAngle = cursor + pct
            cursor += pct
            result.append(point)
        }

        return result
    }()
}

struct DonutChartView: View {
    let data: [ChartDataPoint]

    private let gapSize: Double = 0.008
    private let lineWidth: CGFloat = 34

    @State private var selectedPoint: ChartDataPoint?
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size / 2
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)

            ZStack {
                ForEach(data) { point in
                    Circle()
                        .trim(
                            from: point.startAngle + gapSize,
                            to: point.endAngle - gapSize
                        )
                        .stroke(point.category.color, lineWidth: lineWidth)
                        .rotationEffect(.degrees(-90))
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.25)) {
                                selectedPoint = selectedPoint?.id == point.id ? nil : point
                            }
                        }
                }

                ForEach(data) { point in
                    DonutLabel(
                        point: point,
                        center: center,
                        radius: radius + lineWidth / 2 + 30
                    )
                }

                if let selected = selectedPoint {
                    let mid = ((selected.startAngle + selected.endAngle) / 2) * 360 - 90
                    let rad = mid * .pi / 180
                    let tooltipRadius = radius * 0.45
                    let isLeftSide = mid > 0 && mid < 180

                    ChartTooltip(
                        categoryName: selected.category.rawValue,
                        value: "Rp. \(Int(selected.percentage * 1_680_000_000))",
                        isLeftSide: !isLeftSide
                    )
                    .position(
                        x: center.x + tooltipRadius * cos(rad),
                        y: center.y + tooltipRadius * sin(rad)
                    )
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
}

struct DonutLabel: View {
    let point: ChartDataPoint
    let center: CGPoint
    let radius: CGFloat

    private var midAngle: Double {
        let mid = (point.startAngle + point.endAngle) / 2
        return (mid * 360) - 90
    }

    private var labelPosition: CGPoint {
        let rad = midAngle * .pi / 180
        return CGPoint(
            x: center.x + radius * cos(rad),
            y: center.y + radius * sin(rad)
        )
    }

    var body: some View {
        if point.percentage >= 0.04 {
            HStack(spacing: 2) {
                Image(systemName: point.category.icon)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(.secondary)

                Text("\(Int(point.percentage * 100))%")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            .position(labelPosition)
        }
    }
}

struct AnalyticsChartView: View {
    let data: [ChartDataPoint] = ChartDataPoint.mockData

    var body: some View {
        DonutChartView(data: data)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    AnalyticsChartView()
        .padding()
}
