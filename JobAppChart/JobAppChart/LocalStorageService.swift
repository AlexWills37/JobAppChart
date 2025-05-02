//
//  LocalStorageService.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import SwiftData
import Foundation


/// Sends and receives ApplicationItem models from SwiftData.
class LocalStorageService {
    // Singleton resource for accessing the SwiftData container.
    static let shared = LocalStorageService()
    
    private let configuration = ModelConfiguration(isStoredInMemoryOnly: false, allowsSave: true)

    private let container: ModelContainer
    
    private init() {
        container = try! ModelContainer(for: ApplicationItem.self, configurations: configuration)
    }
    
    /// Returns all ApplicationItem models in the storage.
    ///
    /// - Returns: A list containing the entirety of the app's ApplicationItems.
    func getAllData() -> [ApplicationItem] {
        let context = ModelContext(container)
        
        let allItems = FetchDescriptor<ApplicationItem>()
        
        var results = try? context.fetch(allItems)
        if (results == nil) {
            results = []
        }
        return results!
        
    }
    
    /// Inserts or updates an ApplicationItem in storage.
    /// 
    /// - Parameter toSave: The item to put/update in the database.
    /// - Throws: Errors thrown by an unsuccessful save operation.
    func saveEntry(toSave: ApplicationItem) throws {
        let context = ModelContext(container)
        let id = toSave.id
        
        // NOTE: Due to ApplicationItem.id being labeled Unique in the data model, checking for duplicates may be redundant.
        let inStorage: Bool = (try? context.fetch(FetchDescriptor<ApplicationItem>(
            predicate: #Predicate<ApplicationItem> {$0.id == id}
        )).count > 0) ?? false
        
        if !inStorage {
            context.insert(toSave)
        }
        
        try context.save()
    }
}
