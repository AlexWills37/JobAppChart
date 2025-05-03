//
//  ApplicationItemList.swift
//  JobAppChart
//
//  Created by Alex on 5/3/25.
//

import Combine

class ApplicationItemList: ObservableObject {
    static let shared = ApplicationItemList()
    
    @Published var loadedApplications: [ApplicationItem] = []
    
    private init(){
        loadedApplications = LocalStorageService.shared.getAllData()
    }
   
    func addItem(toAdd: ApplicationItem) {
        try? LocalStorageService.shared.saveEntry(toSave: toAdd)
        if !loadedApplications.contains(where: { item in
            item == toAdd
        }){
            
            loadedApplications.append(toAdd)
        }
//        loadedApplications = []
//        loadedApplications = LocalStorageService.shared.getAllData()
    }
    
}
