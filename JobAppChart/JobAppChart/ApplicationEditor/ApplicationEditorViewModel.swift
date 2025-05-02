//
//  ApplicationEditorViewModel.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import Foundation
import Combine
class ApplicationEditorViewModel {
   
    private var toEdit: ApplicationItem
    @Published var companyName: String
    @Published var positionTitle: String
    @Published var websiteLink: String
    @Published var appliedOnDate: Date
    @Published var status: String
    @Published var notes: String
    
    init(toEdit: ApplicationItem) {
        self.toEdit = toEdit
        self.companyName = toEdit.companyName
        self.positionTitle = toEdit.positionTitle
        self.websiteLink = ""
        self.appliedOnDate = toEdit.dateApplied
        self.status = toEdit.status
        self.notes = ""
    }
    
    convenience init() {
        let newApplicationItem = ApplicationItem()
        self.init(toEdit: newApplicationItem)
    }
    
    
    
    
    
}
