//
//  Application.swift
//  JobAppChart
//
//  Created by alex w on 6/3/25.
//

import Foundation
import GRDB
import Combine

/// GRDB Record Type for Applications.
struct Application: Codable, Identifiable, FetchableRecord, PersistableRecord, Hashable {
    var id: String = UUID().uuidString
    /// Name of the company this application is for.
    var companyName: String
    /// Name of the job this application is for.
    var positionTitle: String
    /// The date the user applied to this position.
    var dateApplied: Date
    /// Custom notes about the applilcation, provided by the user.
    var notes: String?
    /// Optional link to a website associated with this application.
    var websiteLink: String?
    /// Foreign key to this application's status.
    var statusId: Int64
    
    static let status = belongsTo(Status.self)
    
    init(companyName: String = "", positionTitle: String = "", dateApplied: Date = Date.now, status: Status, websiteLink: String = "") {
        self.companyName = companyName
        self.positionTitle = positionTitle
        self.dateApplied = dateApplied
        self.statusId = status.id!
        self.websiteLink = websiteLink
        self.notes = ""
    }
    
    // Enables GRDB Queries.
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let commpanyName = Column(CodingKeys.companyName)
        static let positionTitle = Column(CodingKeys.positionTitle)
        static let dateApplied = Column(CodingKeys.dateApplied)
        static let notes = Column(CodingKeys.notes)
        static let websiteLink = Column(CodingKeys.websiteLink)
        static let statusId = Column(CodingKeys.statusId)
    }
}

