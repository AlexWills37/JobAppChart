//
//  ApplicationItemListViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//
import Combine

/// View Model that manages a list of ApplicationItems to dsiplay.
class ApplicationItemListViewModel: ObservableObject {
    @Published var itemsToShow: [ApplicationItemViewModel] = []
        
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // Get initial items from the database
        LocalStorageService.shared.getAllData().publisher
            .map { itemModel in
                return ApplicationItemViewModel(itemModel: itemModel)
            }
            .sink { [weak self] itemVM in
                guard let self = self else {return}
                itemsToShow.append(itemVM)
            }
            .store(in: &subscriptions)
    }
    
    
    func addItem() {
        print("Saving item")
        try! LocalStorageService.shared.saveEntry(toSave: ApplicationItem(positionTitle: "HEHEHEHO"))
        itemsToShow = LocalStorageService.shared.getAllData().map({ itemModel in
            return ApplicationItemViewModel(itemModel: itemModel)
        })
    }
}
