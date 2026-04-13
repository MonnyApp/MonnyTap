//
//  MonnyTapWidget.swift
//  MonnyTapWidget
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import SwiftUI
import WidgetKit

struct MonnyTapWidgetEntryView: View {
    var entry: MonnyTapWidgetProvider.Entry

    var body: some View {
        if entry.currentView == "categoryList" {
            CategoryListWidgetView(entry: entry)
        } else {
            MainWidgetView(entry: entry)
        }
    }
}

struct MonnyTapWidget: Widget {
    let kind: String = "MonnyTapWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MonnyTapWidgetProvider()) { entry in
            MonnyTapWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Widget Pengeluaran")
        .description("Catat pengeluaran langsung dari home screen.")
        .supportedFamilies([.systemLarge])
    }
}

//#Preview(as: .systemLarge) {
//    MonnyTapWidget()
//} timeline: {
//    MonnyEntry(
//        date: .now,
//        type: .expense,
//        amountDraft: "50000",
//        selectedCategory: .fnb,
//        topCategories: [.fnb, .shopping, .transportation],
//        currentView: "main"
//    )
//    MonnyEntry(
//        date: .now,
//        type: .expense,
//        amountDraft: "",
//        selectedCategory: nil,
//        topCategories: [.fnb, .shopping, .transportation],
//        currentView: "categoryList"
//    )
//}
