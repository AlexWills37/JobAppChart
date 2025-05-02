//
//  ApplicationItem.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import Foundation
import SwiftData

/// The Model for ApplicationItems, stored locally with SwiftData.
@Model class ApplicationItem {
    /// Unique ID to prevent duplicates in SwiftData.
    @Attribute(.unique) var id = UUID()
    
    /// Name of the company this Application is with.
    var companyName: String
    /// Title of the position/target this Applilcation is for.
    var positionTitle: String
    var dateApplied: Date
    /// Current, updateable status of the application.
    var status: String
    
    init(companyName: String = "", positionTitle: String = "", dateApplied: Date = Date.now, status: String = "") {
        self.companyName = companyName
        self.positionTitle = positionTitle
        self.dateApplied = dateApplied
        self.status = status
    }
}
