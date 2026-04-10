//
//  AnalyticsChart.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 08/04/26.
//

import SwiftUI

/// Data Model Chart
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let category: Category
    let amount: Double
    let percentage: Double

    var startAngle: Double = 0
    var endAngle: Double = 0
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
                if data.isEmpty {
                    Circle()
                        .stroke(Color(.systemGray5), lineWidth: lineWidth)
                    Text("No Data")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.secondary)

                } else {
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
                }

                if let selected = selectedPoint {
                    // 0° = top, 90° = right, 180° = bottom, 270° = left
                    let displayAngle = ((selected.startAngle + selected.endAngle) / 2) * 360
                    let positionRad = (displayAngle - 90) * .pi / 180
                    let tooltipRadius = radius * 0.45

                    let sharpCorner: TooltipCorner = {
                        switch displayAngle {
                        case ..<90:  return .topTrailing
                        case ..<180: return .bottomTrailing
                        case ..<270: return .bottomLeading
                        default:     return .topLeading
                        }
                    }()

                    ChartTooltip(
                        categoryName: selected.category.rawValue,
                        value: "Rp. \(Int(selected.amount).formatted())",
                        sharpCorner: sharpCorner
                    )
                    .position(
                        x: center.x + tooltipRadius * cos(positionRad),
                        y: center.y + tooltipRadius * sin(positionRad)
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
    var viewModel: OverviewViewModel

    var body: some View {
        DonutChartView(data: viewModel.chartData)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    AnalyticsChartView(viewModel: OverviewViewModel())
        .padding()
}
