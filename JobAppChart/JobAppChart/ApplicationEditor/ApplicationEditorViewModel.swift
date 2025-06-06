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
    private var toEdit: Application
   
    @Published var allStatuses: [Status] = []
    
    var subscriptions = Set<AnyCancellable>()

    // MARK: Fields directly tied to item model
    @Published var companyName: String
    @Published var positionTitle: String
    @Published var websiteLink: String
    @Published var dateApplied: Date
    @Published var statusId: Int64
    @Published var notes: String
    
    // MARK: Computed values
    /// Whether `toEdit` is a new application being created (not in the database yet), or a previously existing application being edited.
    @Published var newApplication: Bool
    @Published var title: String = "Add a new application"
    // List of status options for the user to choose.
    @Published var statusOptions: [(name: String, id: Int64)] = []
    @Published var notificationEnbaled: Bool = false
    @Published var notificationsNotAuthorized: Bool = false
    
    init(toEdit: Application, isNew: Bool = false) {
        self.toEdit = toEdit
        self.companyName = toEdit.companyName
        self.positionTitle = toEdit.positionTitle
        self.websiteLink = toEdit.websiteLink ?? ""
        self.dateApplied = toEdit.dateApplied
        self.statusId = toEdit.statusId
        self.notes = toEdit.notes ?? ""
        self.newApplication = isNew
        self.allStatuses = LocalDatabase.shared.getAllStatuses()
        
        // Create status options for the View
        for status in allStatuses {
            self.statusOptions.append((status.statusName, status.id!))
        }
        
        updateNotificationStatus()
        addTitleSubscriber()
    }
    
    /// Creates an Editor View Model with a new, empty application.
    convenience init() {
        let newApplicationItem = Application(status: LocalDatabase.shared.getAllStatuses()[0])
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
    
    /// Asynchronously edits the displayed notification status if there is a notification pending.
    func updateNotificationStatus() {
        Task { @MainActor in
            notificationEnbaled = await NotificationService.shared.isNotificationPending(toEdit.id)
        }
    }
    
    /// Saves the currently written values to the Application Item's model and updates the Item List.
    func saveEntry() -> Application {
        // Update the actual Item model
        toEdit.companyName = self.companyName
        toEdit.positionTitle = self.positionTitle
        toEdit.websiteLink = self.websiteLink
        toEdit.dateApplied = self.dateApplied
        toEdit.statusId = self.statusId
        toEdit.notes = self.notes
        do {
            try LocalDatabase.shared.setApplication(toEdit)
        }
        catch {
            print("Error when trying to save an application: \(error)")
        }
        
        // Schedule notification if enabled
        if notificationEnbaled {
            let notificationDate = Calendar.current.date(byAdding: .day, value: 14, to: self.dateApplied)!
            var notificationDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: notificationDate)
            notificationDateComponents.hour = 12
            notificationDateComponents.minute = 0
            notificationDateComponents.second = 0
            Task { @MainActor in
                await NotificationService.shared.scheduleNotification(title: "Follow up on your application!", body: "It's been 14 days since you applied to \(self.companyName). Have you received any updates?", date: notificationDateComponents, id: toEdit.id)
            }
        } else {
            NotificationService.shared.cancelNotification(toEdit.id)
        }

        return toEdit
    }
    
    /// Deletes the entry being edited and removes it from the Item List.
    func deleteEntry() {
        try? LocalDatabase.shared.deleteApplication(toEdit)
    }
    
    /// Toggles a flag for whether or not a notification should be created or unchedules when this application is saved.
    /// Asks users for notification permissions if this is the first attempt.
    func toggleNotification() {
        if (!notificationEnbaled) {
            Task { @MainActor in
                let authorized = await NotificationService.shared.requestPermissions()
                if authorized {
                   notificationEnbaled = true
                } else {
                    notificationsNotAuthorized = true
                }
            }

        } else {
            notificationEnbaled = false
        }
    }
}
