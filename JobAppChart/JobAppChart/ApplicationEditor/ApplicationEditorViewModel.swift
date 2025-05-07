//
//  ApplicationEditorViewModel.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import Foundation
import Combine
class ApplicationEditorViewModel: ObservableObject {
   
    /// The Item object actively being worked on by this editor instance.
    private var toEdit: ApplicationItem
    
    var subscriptions = Set<AnyCancellable>()

    // MARK: Fields directly tied to item model
    @Published var companyName: String
    @Published var positionTitle: String
    @Published var websiteLink: String
    @Published var dateApplied: Date
    @Published var status: String
    @Published var notes: String
    
    // MARK: Computed values
    /// Whether `toEdit` is a new application being created (not in the database yet), or a previously existing application being edited.
    @Published var newApplication: Bool
    @Published var title: String = "Add a new application"
    @Published var statusOptions: [String] = []
    
    init(toEdit: ApplicationItem, isNew: Bool = false) {
        self.toEdit = toEdit
        self.companyName = toEdit.companyName
        self.positionTitle = toEdit.positionTitle
        self.websiteLink = toEdit.websiteLink
        self.dateApplied = toEdit.dateApplied
        self.status = toEdit.status
        self.notes = toEdit.notes
        self.newApplication = isNew
        self.statusOptions = StatusList.shared.getOrderedStatuses()
        addTitleSubscriber()
    }
    
    /// Creates an Editor View Model with a new, empty application.
    convenience init() {
        let newApplicationItem = ApplicationItem(status: "Applied")
        self.init(toEdit: newApplicationItem, isNew: true)
    }
    
    /// Listens to the job position and company name fields to update the editor's title when it changes.
    func addTitleSubscriber() {
        $positionTitle.combineLatest($companyName)
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] position, title in
                guard let self = self else {return}
                guard !newApplication else {return}
                self.title = "\(position) at \(title)"
            }
            .store(in: &subscriptions)
    }
    
    
    /// Saves the currently written values to the Application Item's model and updates the Item List.
    func saveEntry() -> ApplicationItem {
        // Update the actual Item model
        toEdit.companyName = self.companyName
        toEdit.positionTitle = self.positionTitle
        toEdit.websiteLink = self.websiteLink
        toEdit.dateApplied = self.dateApplied
        toEdit.status = self.status
        toEdit.notes = self.notes
        
        ApplicationItemListViewModel.shared.updateItemFromModel(toUpdate: toEdit)
        try? LocalStorageService.shared.saveEntry(toSave: toEdit)

        return toEdit
    }
    
    /// Deletes the entry being edited and removes it from the Item List.
    func deleteEntry() {
        try? LocalStorageService.shared.deleteEntry(toDelete: toEdit)
        ApplicationItemListViewModel.shared.deleteItem(toDelete: toEdit)
    }
}
