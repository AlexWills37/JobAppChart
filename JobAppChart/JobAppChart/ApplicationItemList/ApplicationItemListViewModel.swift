//
//  ApplicationItemListViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//
import Combine
import Foundation

/// View Model that manages a list of ApplicationItems to dsiplay.
class ApplicationItemListViewModel: ObservableObject {
    
    /// List of View Model lists to build the view. Each list of View Models is a "group," intended to display together, separated from other groups.
    @Published var groupedItemsToShow: [[ApplicationItemViewModel]] = []
    
    /// Primary storage for the currently loaded View Models based on their application ID.
    var itemIdsToViewModels: [String: ApplicationItemViewModel] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        // Retrieve all applications from the database.
        let loadedItemModels = LocalDatabase.shared.getAllApplicationsSorted()
        print("Loaded \(loadedItemModels.count) items")
        
        // Create the ordered list for all the application records in the database.
        rebuildGroupedList()
        
        // Subscription to update objects when the applications table is altered.
        LocalDatabase.shared.getApplicationObservationPublisher()
            .sink { completion in } receiveValue: { [weak self] applications in
                guard let self = self else {return}
                self.rebuildGroupedList()
            }
            .store(in: &subscriptions)

    }
    
    // MARK: - Maintaining the state of the list
    
    /// Iterates through all Applications in the database and sorts/organizes them into the published list of VMs to display.
    func rebuildGroupedList() {
        self.groupedItemsToShow = []
        
        let sortedApplicationInfos = LocalDatabase.shared.getAllApplicationsSorted()
        
        // Track the item IDs that are still in the database, so we can remove any items that are no longer present.
        var persistingItemIds: Set<String> = []
        
        // Group and update all applications.
        var group: [ApplicationItemViewModel] = []
        var current: ApplicationInfo
        for i in 0..<sortedApplicationInfos.count {
            // Add the current application's VM to the current group.
            current = sortedApplicationInfos[i]
            var vm = self.itemIdsToViewModels[current.application.id]
            
            // Create a new VM, or reassign the new model to an existing VM.
            if (vm === nil) {
                vm = ApplicationItemViewModel(itemModel: current)
                self.itemIdsToViewModels[current.application.id] = vm
            } else {
                vm?.refreshModel(current.application)
            }
            group.append(vm!)
            
            // Add the group to the list and start a new one if we are at the end of the current group.
            if (i + 1 >= sortedApplicationInfos.count || sortedApplicationInfos[i + 1].status.id != current.status.id) {
                self.groupedItemsToShow.append(group)
                group = []
            }
            
            // Add this item's ID to a set to prevent its removal.
            persistingItemIds.insert(current.application.id)
        }
        
        // Remove any VMs that were not provided by the database.
        for itemId in self.itemIdsToViewModels.keys {
            if (!persistingItemIds.contains(itemId)) {
                self.itemIdsToViewModels.removeValue(forKey: itemId)
            }
        }
    }
    
}
