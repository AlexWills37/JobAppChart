//
//  ApplicationItemListViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//
import Combine

/// View Model that manages a list of ApplicationItems to dsiplay.
class ApplicationItemListViewModel: ObservableObject {
    static let shared = ApplicationItemListViewModel()
    
    
    @Published var groupedItemsToShow: [[ApplicationItemViewModel]] = []
    
    var loadedItemModels: [ApplicationItem] = []
    var itemModelsToViewModels: [ApplicationItem: ApplicationItemViewModel] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    private init() {
        loadedItemModels = LocalStorageService.shared.getAllData()
        for model in loadedItemModels {
            let viewModel = ApplicationItemViewModel(itemModel: model)
            itemModelsToViewModels[model] = viewModel
        }
        refreshList()
        sortByDateApplied()
    }
    
    // MARK: - Maintaining the state of the list
    
    /// Refreshes the data of a particular Application Item View Model according to the Application Item Model.
    ///
    /// - Parameter toUpdate: The ApplicationItem (model) of the ViewModel to update.
    func updateItemFromModel(toUpdate: ApplicationItem) {
        
        if !loadedItemModels.contains(where: { other in
            return other == toUpdate
        }) {
            loadedItemModels.append(toUpdate)
            let viewModel = ApplicationItemViewModel(itemModel: toUpdate)
            itemModelsToViewModels[toUpdate] = viewModel
        }
        
        itemModelsToViewModels[toUpdate]?.refreshDataFromModel()
        refreshList()
        sortByDateApplied()
    }
    
    /// Refreshes every View Model according to their Item Models.
    func refreshViewModels() {
        for vm in itemModelsToViewModels.values {
            vm.refreshDataFromModel()
        }
    }
    
    /// Removes an ApplicationItem and its corresponding ViewModel from the list.
    func deleteItem(toDelete: ApplicationItem) {
        itemModelsToViewModels.removeValue(forKey: toDelete)
        loadedItemModels.removeAll { model in
            model == toDelete
        }
        refreshList()
    }
    
    /// Iterates through all loaded View Models and sorts/organizes them into the published list to display.
    func refreshList() {
        self.groupedItemsToShow = []
        let knownStatuses = StatusList.shared.getOrderedStatuses(.displayGroup)
        let sortedViewModels = self.itemModelsToViewModels.values.sorted { lhs, rhs in
            lhs.dateApplied > rhs.dateApplied
        }
        for status in knownStatuses {
            var group: [ApplicationItemViewModel] = []
            
            for vm in sortedViewModels {
                if (vm.status == status) {
                    group.append(vm)
                }
            }
            
            if group.count > 0 {
                self.groupedItemsToShow.append(group)
            }
        }
        
        var otherGroup: [ApplicationItemViewModel] = []
        for vm in sortedViewModels {
            if !knownStatuses.contains([vm.status]) {
                otherGroup.append(vm)
            }
        }
        if otherGroup.count > 0 {
            self.groupedItemsToShow.append(otherGroup)
        }
    }
    
    // MARK: - Filtering and sorting
    func sortByDateApplied(ascending: Bool = false) {
        loadedItemModels.sort { lhs, rhs in
            if ascending {
                return lhs.dateApplied < rhs.dateApplied
            }
            return lhs.dateApplied > rhs.dateApplied
        }
    }
}
