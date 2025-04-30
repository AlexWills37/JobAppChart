//
//  ApplicationItemViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import Foundation
import SwiftUI
import Combine

class ApplicationItemViewModel: ObservableObject, Identifiable {
    //private var model: ApplicationItem
    @Published var companyName: String = "Peanut Company"
    @Published var positionTitle: String = "Software Engineer I"
    @Published var websiteLink: String = ""
    @Published var status: String = "Applied"
    @Published var dateApplied: Date = Date().addingTimeInterval(-1 * 60 * 60 * 24 * 20)
    @Published var daysSinceUpdate = 0
    
    @Published var statusColor = Color(#colorLiteral(red: 0.8320404887, green: 0.9654800296, blue: 0.9295234084, alpha: 1))
    
    var test: AnyCancellable?
    var subscriptions = Set<AnyCancellable>()
    var count: Int = 0
    
    init(companyName: String, positionTitle: String, websiteLink: String, status: String, dateApplied: Date) {
        self.companyName = companyName
        self.positionTitle = positionTitle
        self.websiteLink = websiteLink
        self.status = status
        self.dateApplied = dateApplied
        self.daysSinceUpdate = daysSinceUpdate
        self.statusColor = statusColor
        
        setup()
    }
    init() {
        setup()
    }
    
    func setup() {
        
        self.updateDaysSinceStatusUpdate()
        
        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: .main) { [weak self] _ in
            guard let self else {return}
            self.updateDaysSinceStatusUpdate()
        }

    }
    
    func updateDaysSinceStatusUpdate() {
        self.daysSinceUpdate = Calendar.current.dateComponents([.day], from: dateApplied, to: Date.now).day!
    }
    
    
}
