//
//  ApplicationItem.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import Foundation
//import Combine
//
//class ApplicationItem: ObservableObject {
//    var id = UUID()
//    @Published var companyName: String = ""
//    @Published var positionTitle: String = ""
//    @Published var dateApplied: Date = Date.now
//    @Published var status: String = ""
//    
//    init(companyName: String, positionTitle: String, dateApplied: Date, status: String) {
//        
//        self.companyName = companyName
//        self.positionTitle = positionTitle
//        self.dateApplied = dateApplied
//        self.status = status
//
//    }
//}

import SwiftData
@Model class ApplicationItem {
    var id = UUID()
    var companyName: String
    var positionTitle: String
    var dateApplied: Date
    var status: String
    
    init(companyName: String = "", positionTitle: String = "", dateApplied: Date = Date.now, status: String = "") {
        self.companyName = companyName
        self.positionTitle = positionTitle
        self.dateApplied = dateApplied
        self.status = status
    }
}
