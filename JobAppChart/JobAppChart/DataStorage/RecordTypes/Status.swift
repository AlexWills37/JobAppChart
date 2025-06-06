//
//  Status.swift
//  JobAppChart
//
//  Created by alex w on 6/4/25.
//

import Foundation
import GRDB

/// GRDB Record Type for an application's Status.
struct Status: Codable, Identifiable, FetchableRecord, MutablePersistableRecord {
    var id: Int64?  // Auto-assigned id upon database insertion.
    var statusName: String
    
    /// RGB values for the color this status should display as (format: 0x--RRGGBB).
    var color: Int32
    
    /// Ordering to display this status in the editor's picker, when choosing a status.
    var pickerPriority: Int64 = 0
    /// Ordering to display this status's applications on the main listing page.
    var displayPriority: Int64 = 0
    
    static let applications = hasMany(Application.self)
   
    // Obtains the id assigned by the database.
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
    
    // Allows for using column information in GRDB Query Requests.
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let statusName = Column(CodingKeys.statusName)
        static let color = Column(CodingKeys.color)
        static let pickerPriority = Column(CodingKeys.pickerPriority)
        static let displayPriority = Column(CodingKeys.displayPriority)
    }
}
