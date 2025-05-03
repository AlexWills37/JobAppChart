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
    var model: ApplicationItem
    
    var id: UUID
    
    // MARK: Directly exposed model values.
    @Published var companyName: String
    @Published var positionTitle: String
    @Published var websiteLink: String
    @Published var status: String
    @Published var dateApplied: Date?
    
    // MARK: Calculated values for the view.
    @Published var daysSinceUpdate: Int = 0
    @Published var statusColor: Color = Color(#colorLiteral(red: 0.8320404887, green: 0.9654800296, blue: 0.9295234084, alpha: 1))
    
    var subscriptions = Set<AnyCancellable>()
    
    init(itemModel: ApplicationItem) {
        self.id = itemModel.id
        self.model = itemModel
        self.companyName = itemModel.companyName
        self.positionTitle = itemModel.positionTitle
        self.status = itemModel.status
        self.dateApplied = itemModel.dateApplied
        self.websiteLink = ""
        self.updateDaysSinceStatusUpdate()

        setUpSubscriptions()
    }
    
    func setUpSubscriptions() {
        // Refresh the daysSinceUpdate count when the calendar changes
        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: .main) { [weak self] _ in
            guard let self else {return}
            self.updateDaysSinceStatusUpdate()
        }

    }
    
    func updateDaysSinceStatusUpdate() {
        guard let dateApplied = dateApplied else {return}
        self.daysSinceUpdate = Calendar.current.dateComponents([.day], from: dateApplied, to: Date.now).day!
    }
    
    // MARK: Conforming to Hashable and Equatable
    static func == (lhs: ApplicationItemViewModel, rhs: ApplicationItemViewModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
}
