//
//  LocalDatabase+Migrator.swift
//  JobAppChart
//
//  Created by alex w on 6/3/25.
//

import Foundation
import GRDB

/// Adds the SQL schema/database migrations to the database.
extension LocalDatabase {
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        // MARK: - v1 - Initial schema
        // Contains a status table, where each status has a name, color, and priorities for ordering; and an application table, where each application contains a status, among other information.
        migrator.registerMigration("v1") { db in
            try db.create(table: "status") { table in
                table.autoIncrementedPrimaryKey("id")
                table.column("statusName", .text).notNull()
                table.column("color", .integer).notNull()
                table.column("pickerPriority", .integer).notNull()
                table.column("displayPriority", .integer).notNull()
            }
            try db.create(table: "application") { table in
                table.primaryKey("id", .text).notNull()
                table.column("companyName", .text).notNull()
                table.column("positionTitle", .text).notNull()
                table.column("dateApplied", .date).notNull()
                table.column("notes", .text)
                table.column("websiteLink", .text)
                table.belongsTo("status", onDelete: .none).notNull()
            }
        }
        return migrator
    }
    
}
