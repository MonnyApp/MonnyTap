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

    static var storeURL: URL? = {
        FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: appGroupID)?
            .appendingPathComponent("MonnyTap.sqlite")
    }()

    static let modelContainer: ModelContainer = {
        let schema = Schema([Transaction.self])

        if let url = storeURL {
            let config = ModelConfiguration(schema: schema, url: url)
            do {
                return try ModelContainer(for: schema, configurations: [config])
            } catch {
                // Fall through to default container
            }
        }

        // Fallback: use default container
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
