//
//  MonnyTapApp.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 07/04/26.
//

import SwiftUI
import SwiftData

@main
struct MonnyTapApp: App {
    var sharedModelContainer: ModelContainer = SharedModelContainer.modelContainer

    var body: some Scene {
        WindowGroup {
            OverviewView()
        }
        .modelContainer(sharedModelContainer)
    }
}
