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
    @Published var itemsToShow: [ApplicationItemViewModel] = []
    var loadedItemModels: [ApplicationItem] = []
    
    var itemModelsToViewModels: [ApplicationItem: ApplicationItemViewModel] = [:]
    
        
    var subscriptions = Set<AnyCancellable>()
    
    private init() {
        loadedItemModels = LocalStorageService.shared.getAllData()
        for model in loadedItemModels {
            let viewModel = ApplicationItemViewModel(itemModel: model)
            itemsToShow.append(viewModel)
            itemModelsToViewModels[model] = viewModel
        }
    }
    
    
    func updateItemFromModel(toUpdate: ApplicationItem) {
        
        if !loadedItemModels.contains(where: { other in
            return other == toUpdate
        }) {
            loadedItemModels.append(toUpdate)
            let viewModel = ApplicationItemViewModel(itemModel: toUpdate)
            itemsToShow.append(viewModel)
            itemModelsToViewModels[toUpdate] = viewModel
        }
        
        itemModelsToViewModels[toUpdate]?.refreshDataFromModel()
    }
    
    func refreshViewModels() {
        for vm in itemsToShow {
            vm.refreshDataFromModel()
        }
    }
    
    func deleteItem(toDelete: ApplicationItem) {
        itemsToShow.removeAll { viewModel in
            viewModel.model == toDelete
        }
        itemModelsToViewModels.removeValue(forKey: toDelete)
        loadedItemModels.removeAll { model in
            model == toDelete
        }
    }
    
}
