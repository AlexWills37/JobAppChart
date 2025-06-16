//
//  ApplicationItemDetailViewModel.swift
//  JobAppChart
//
//  Created by alex w on 6/13/25.
//

import Combine
import Foundation
import SwiftUI

class ApplicationItemDetailViewModel: ObservableObject {
    /// An editor instance to perform quick edits with, and to create a full editor modal upon clicking an edit button.
    var editor: ApplicationEditorViewModel
    
    /// The application to show detailed information with.
    /// Quick edits made with the editor will affect this instance as well.
    @Published private var toDisplay: Application
    @Published private var selectedStatus: Status?

    // MARK: Fields directly tied to item model
    var companyName: String { toDisplay.companyName }
    var positionTitle: String { toDisplay.positionTitle }
    var websiteLink: String { toDisplay.websiteLink ?? ""}
    var dateApplied: Date { toDisplay.dateApplied }
    var daysSinceApplication: Int { toDisplay.daysSinceApplication }
    var notes: String { toDisplay.notes ?? ""}
    
    var statusName: String { selectedStatus?.statusName ?? "N/A"}
    
    // MARK: Computed properties
    var pageTitle: String {
        "\(positionTitle) at \(companyName)"
    }
    var statusColor: Color {
        ColorTool.makeColor(selectedStatus?.color ?? 0xFFFFFF)
    }

    var subscriptions = Set<AnyCancellable>()
    
    init(applicationModel: Application) {
        self.toDisplay = applicationModel
        self.editor = ApplicationEditorViewModel(toEdit: applicationModel)
        
        // Subscription to sync status information with the application model.
        $toDisplay.map(\.statusId)
            .map { id in
                LocalDatabase.shared.getStatus(id)
            }
            .sink { [weak self] status in
                guard let self = self else {return}
                self.selectedStatus = status
            }
            .store(in: &subscriptions)
    }
    
    /// Retrieves a more up-to-date model for the Application from the database.
    func refreshApplicationModel() {
        self.toDisplay = LocalDatabase.shared.getApplication(toDisplay.id)!
        // TODO: instead of creating a new editor when a change is made, we should either swap out the `toEdit` model, or implement quick edits independently, lazily creating the full editor with the most recent model.
        // This sub-optimal approach is only included because it works without modifying the editor.
        self.editor = ApplicationEditorViewModel(toEdit: toDisplay)
    }
    
}
