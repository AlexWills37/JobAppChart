//
//  LocalStorageService.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import SwiftData



class LocalStorageService {
    static let shared = LocalStorageService()
    let configuration = ModelConfiguration(isStoredInMemoryOnly: false, allowsSave: true)

    let container: ModelContainer
    
    private init() {
        container = try! ModelContainer(for: ApplicationItem.self, configurations: configuration)
    }
    
    func getAllData() -> [ApplicationItem] {
        let context = ModelContext(container)
        
        let allItems = FetchDescriptor<ApplicationItem>()
        
        var results = try? context.fetch(allItems)
        if (results == nil) {
            results = []
        }
        return results!
        
    }
    
    func saveEntry(toSave: ApplicationItem) throws {
        let context = ModelContext(container)
        context.insert(toSave)
        try context.save()
        print("Saved item")
    }
}
