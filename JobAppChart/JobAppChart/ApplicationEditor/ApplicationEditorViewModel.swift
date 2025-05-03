//
//  ApplicationEditorViewModel.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import Foundation
import Combine
class ApplicationEditorViewModel: ObservableObject {
   
    private var toEdit: ApplicationItem
    @Published var companyName: String
    @Published var positionTitle: String
    @Published var websiteLink: String
    @Published var dateApplied: Date
    @Published var status: String
    @Published var notes: String
    
    var test: AnyCancellable?
    
    init(toEdit: ApplicationItem) {
        self.toEdit = toEdit
        self.companyName = toEdit.companyName
        self.positionTitle = toEdit.positionTitle
        self.websiteLink = toEdit.websiteLink
        self.dateApplied = toEdit.dateApplied
        self.status = toEdit.status
        self.notes = toEdit.notes
        
    }
    
    convenience init() {
        let newApplicationItem = ApplicationItem(status: "Applied")
        self.init(toEdit: newApplicationItem)
    }
    
    
    func saveEntry() -> ApplicationItem {
        // Update the actual Item model
        toEdit.companyName = self.companyName
        toEdit.positionTitle = self.positionTitle
        toEdit.websiteLink = self.websiteLink
        toEdit.dateApplied = self.dateApplied
        toEdit.status = self.status
        toEdit.notes = self.notes
        
        ApplicationItemList.shared.addItem(toAdd: toEdit)
        ApplicationItemListViewModel.shared.refreshViewModels()
        
        return toEdit
    }
    
    
}

