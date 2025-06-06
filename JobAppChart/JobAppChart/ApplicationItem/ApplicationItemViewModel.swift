//
//  ApplicationItemViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import Foundation
import SwiftUI
import Combine

/// View Model exposing an ApplicationItem's base values and calculated properties.
class ApplicationItemViewModel: ObservableObject, Identifiable, Hashable {
    
    /// The main source of information for this ApplicationItem.
    var model: Application
    
    /// The source of information for this ApplicationItem's Status.
    @Published private var statusModel: Status

    /// The id shared by this View Model and the underlying Application model.
    var id: String
    
    // MARK: Directly exposed model values.
    @Published var companyName: String
    @Published var positionTitle: String
    @Published var websiteLink: String
    @Published var statusName: String
    @Published var dateApplied: Date
    
    // MARK: Calculated values for the view.
    @Published var daysSinceUpdate: Int = 0
    @Published var statusColor: Color = Color(#colorLiteral(red: 0.8320404887, green: 0.9654800296, blue: 0.9295234084, alpha: 1))
    @Published var isStatusColorLight: Bool = true
    
    var subscriptions = Set<AnyCancellable>()
    
    init(itemModel: ApplicationInfo) {
        self.id = itemModel.application.id
        self.model = itemModel.application
        self.companyName = itemModel.application.companyName
        self.positionTitle = itemModel.application.positionTitle
        self.statusName = itemModel.status.statusName
        self.statusModel = itemModel.status
        self.dateApplied = itemModel.application.dateApplied
        self.websiteLink = itemModel.application.websiteLink ?? ""

        addDaysSinceSubscriptions()
        addStatusUpdateSubscription()
    }
    
    /// Adds observers to update the computed `daysSinceUpdate` field if the calendar day changes, and if the `dateApplied` changes.
    func addDaysSinceSubscriptions() {
        // Refresh the daysSinceUpdate count when the calendar changes
        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: .main) { [weak self] _ in
            guard let self else {return}
            self.updateDaysSinceStatusUpdate()
        }
        
        self.$dateApplied.sink { [weak self] newDate in
            guard let self = self else {return}
            self.daysSinceUpdate = Calendar.current.dateComponents([.day], from: newDate, to: Date.now).day!
        }.store(in: &subscriptions)
    }
    
    /// Adds a subscription to the item's status to update `statusColor` and `statusName` when `status` changes.
    func addStatusUpdateSubscription() {
        self.$statusModel
            .sink { [weak self] newStatus in
                guard let self = self else {return}
                self.statusName = newStatus.statusName
                self.statusColor = ColorTool.makeColor(newStatus.color)
            }
            .store(in: &subscriptions)
    }
    
    /// Refreshes the View Model with a more updated Model.
    ///
    /// - Parameter application: The new Application model to declare this item's state.
    func refreshModel(_ application: Application) {
        if (self.model.id != application.id) {
            print("WARNING: Attempting to set this ApplicationItemViewModel's model to an application with a different ID!")
        }
        self.model = application
        self.companyName = application.companyName
        self.positionTitle = application.positionTitle
        self.statusModel = LocalDatabase.shared.getStatus(application.statusId) ?? self.statusModel
        self.dateApplied = application.dateApplied
        self.websiteLink = application.websiteLink ?? ""
    }
    
    /// Calculates the days since the `dateApplied` value, storing it in `daysSinceUpdate`.
    func updateDaysSinceStatusUpdate() {
        self.daysSinceUpdate = Calendar.current.dateComponents([.day], from: dateApplied, to: Date.now).day!
    }
    
    // MARK: - Conforming to Hashable and Equatable
    static func == (lhs: ApplicationItemViewModel, rhs: ApplicationItemViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
}
