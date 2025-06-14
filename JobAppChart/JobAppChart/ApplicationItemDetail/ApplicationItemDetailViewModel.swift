//
//  ApplicationItemDetailViewModel.swift
//  JobAppChart
//
//  Created by alex w on 6/13/25.
//

import Combine
import Foundation

class ApplicationItemDetailViewModel: ObservableObject {
    /// An editor instance to perform quick edits with, and to create a full editor modal upon clicking an edit button.
    var editor: ApplicationEditorViewModel
    
    /// The application to show detailed information with.
    /// Quick edits made with the editor will affect this instance as well.
    var toDisplay: Application

    // MARK: Fields directly tied to item model
    @Published var companyName: String = ""
    @Published var positionTitle: String = ""
    @Published var websiteLink: String = ""
    @Published var dateApplied: Date = Date.now
    @Published var statusId: Int64 = 0
    @Published var notes: String = ""
    
    var pageTitle: String {
        "\(positionTitle) at \(companyName)"
    }

    var subscriptions = Set<AnyCancellable>()
    
    init(applicationModel: Application) {
        self.toDisplay = applicationModel
        self.editor = ApplicationEditorViewModel(toEdit: applicationModel)
        refreshModelProxies()
        
    }
    
    func refreshModelProxies() {
        self.toDisplay = LocalDatabase.shared.getApplication(toDisplay.id)!
        self.companyName = toDisplay.companyName
        self.positionTitle = toDisplay.positionTitle
        self.websiteLink = toDisplay.websiteLink ?? ""
        self.dateApplied = toDisplay.dateApplied
        self.statusId = toDisplay.statusId
        self.notes = toDisplay.notes ?? ""
    }
    
}
