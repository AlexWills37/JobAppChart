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
    let listModel = ApplicationItemList.shared
        
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        addListSubscription()
    }
    
    func addListSubscription() {
        listModel.$loadedApplications
            .sink { [weak self] newList in
                guard let self = self else {return}
                // Update itemsToShow with the new contents of the list
                self.itemsToShow = []
                for item in newList {
                    self.itemsToShow.append(ApplicationItemViewModel(itemModel: item))
                }
            }
            .store(in: &subscriptions)
    }
    
}
