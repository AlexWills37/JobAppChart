//
//  ApplicationItem.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import Foundation
import SwiftData

@Model class ApplicationItem {
    //var id = UUID()
    var companyName: String
    var positionTitle: String
    var dateApplied: Date
    var status: String
    
    init(companyName: String, positionTitle: String, dateApplied: Date, status: String) {
        
        self.companyName = companyName
        self.positionTitle = positionTitle
        self.dateApplied = dateApplied
        self.status = status
        
    }
}
