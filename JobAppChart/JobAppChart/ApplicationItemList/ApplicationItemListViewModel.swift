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
    
    /// Exposes the user's sort preferences and the SQL queries that facilitate them.
    @Published var sortBar: SortBarViewModel = SortBarViewModel()
    var orderQuery: String = ""
    var filteredStatuses: [Int64] = []
    
    /// Primary storage for the currently loaded View Models based on their application ID.
    var itemIdsToViewModels: [String: ApplicationItemViewModel] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        // Subscription to update objects when the applications table is altered.
        LocalDatabase.shared.getApplicationObservationPublisher()
            .sink { completion in } receiveValue: { [weak self] applications in
                guard let self = self else {return}
                self.rebuildApplicationList(groupByStatus: sortBar.groupByStatus)
            }
            .store(in: &subscriptions)
        
        // Subscription to update objects when the user's sorting preferences change.
        sortBar.$sortOrder.combineLatest(sortBar.$groupByStatus)
            .sink { [weak self] sortOption, groupByStatus in
                guard let self = self else {return}
                self.updateOrder(groupByStatus: groupByStatus, dateSort: sortOption)
                self.rebuildApplicationList(groupByStatus: groupByStatus)
            }.store(in: &subscriptions)
        
        // Subscription to update objects when the user's filter preferences change.
        sortBar.$statusFilters
            .map { dictionary in
                dictionary.filter { element in
                    element.value
                }
                .keys
            }
            .sink { [weak self] selectedKeys in
                guard let self = self else {return}
                self.filteredStatuses = Array(selectedKeys)
                self.rebuildApplicationList(groupByStatus: self.sortBar.groupByStatus)
            }
            .store(in: &subscriptions)
        }
    
    // MARK: - Maintaining the state of the list
    
    /// Iterates through all Applications in the database and sorts/organizes them into the published list of VMs to display.
    ///
    ///  - Parameter groupByStatus: Whether the retrieved list of applications should be split into groups of matching statuses. Defaults true. Set to false if the orderQuery does not begin by sorting by status.
    func rebuildApplicationList(groupByStatus: Bool = true) {
        self.groupedItemsToShow = []
        
        let sortedApplicationInfos = LocalDatabase.shared.getAllApplicationsSorted(self.orderQuery, filteredStatuses: self.filteredStatuses)
        
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
            if (i + 1 >= sortedApplicationInfos.count || (groupByStatus && sortedApplicationInfos[i + 1].status.id != current.status.id)) {
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
    
    /// Builds the SQL query to order the list of applications, based on the user's selected order settings.
    ///
    /// - Parameters:
    ///     - groupByStatus: Whether the search query should group applications based on their status.
    ///     - dateSort: How the search query should sort applications based on their `dateApplied` field.
    func updateOrder(groupByStatus: Bool = true, dateSort: SortOption) {
        let dateAscending = dateSort == .oldestFirst
        self.orderQuery = (groupByStatus ? "status.displayPriority DESC, " : "")
        + "dateApplied " + (dateAscending ? "ASC" : "DESC")
    }
    
}

enum SortOption {
    case newestFirst
    case oldestFirst
}
