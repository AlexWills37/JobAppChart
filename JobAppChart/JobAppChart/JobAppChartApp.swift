//
//  JobAppChartApp.swift
//  JobAppChart
//
//  Created by Alex on 4/28/25.
//

import SwiftUI
import SwiftData
import Foundation

@main
struct JobAppChartApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//            ApplicationItemListView()
            ApplicationListScreenView()
        }
//        .modelContainer(for: ItemDBModel.self)
    }
}
