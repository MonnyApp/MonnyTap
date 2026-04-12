//
//  SharedModelContainer.swift
//  MonnyTap
//
//  Created by Fikrah Damar Huda on 12/04/26.
//

import Foundation
import SwiftData

enum SharedModelContainer {
    static let appGroupID = "group.com.MonnyApp.MonnyTap"

    static let storeURL: URL = {
        guard let url = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: appGroupID) else {
            fatalError("App Group container not found for \(appGroupID)")
        }
        return url.appendingPathComponent("MonnyTap.sqlite")
    }()

    static let modelContainer: ModelContainer = {
        let schema = Schema([Transaction.self])
        let config = ModelConfiguration(
            schema: schema,
            url: storeURL
        )

        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create shared ModelContainer: \(error)")
        }
    }()
}
