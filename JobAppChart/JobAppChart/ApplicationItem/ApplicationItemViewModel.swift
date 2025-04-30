//
//  ApplicationItemViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import Foundation
import SwiftUI
import Combine

class ApplicationItemViewModel: ObservableObject {
    //private var model: ApplicationItem
    @Published var companyName: String = "Peanut Company"
    @Published var positionTitle: String = "Software Engineer I"
    @Published var websiteLink: String = ""
    @Published var status: String = "Applied"
    @Published var dateApplied: Date = Date().addingTimeInterval(-1 * 60 * 60 * 24 * 20)
    @Published var daysSinceUpdate = 0
    
    @Published var statusColor = Color.orange
    
    var test: AnyCancellable?
    var subscriptions = Set<AnyCancellable>()
    var count: Int = 0
    
    init() {

        self.daysSinceUpdate = Calendar.current.dateComponents([.day], from: dateApplied, to: Date.now).day!
        setup()
    }
    
    func setup() {
        Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self else {return}
                
                self.count += 1
                if (self.count % 2 == 0) {
                    self.statusColor = .blue
                }
                else {
                    self.statusColor = .orange
                }


                
            })
            .store(in: &self.subscriptions)
        
        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: .main) { [weak self] _ in
            guard let self else {return}
            self.daysSinceUpdate = Calendar.current.dateComponents([.day], from: dateApplied, to: Date.now).day!
            print("Updated date")
            
        }

    }
    
    
}
