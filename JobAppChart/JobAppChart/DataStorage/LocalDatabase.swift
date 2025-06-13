//
//  Database.swift
//  JobAppChart
//
//  Created by alex w on 6/3/25.
//

import Foundation
import GRDB
import Combine


/// Access to a SQLite database through GRDB and a singleton connection that remains open as long as the app is.
class LocalDatabase {
   
    static let shared = makeShared()
    
    var dbQueue: DatabaseQueue
    
    
    /// Retrieves all applications from the database with a default ordering, based on application status and dateApplied.
    ///
    /// - Parameters
    ///   - sortQuery: SQL statement to insert in the ORDER BY clause. Defaults to sorting by `displayPriority DESC, dateApplied DESC`.
    ///   - filteredStatuses: List of Status IDs to include in the search. Leave blank to include all statuses.
    /// - Returns: Ordered list of ApplicationInfo objects.
    func getAllApplicationsSorted(_ sortQuery: String = "status.displayPriority DESC, dateApplied DESC", filteredStatuses: [Int64] = [], searchQuery: String = "") -> [ApplicationInfo] {
        var allApplications: [ApplicationInfo] = []
        let statusAlias: TableAlias<Status> = TableAlias<Status>()
        
        do {
            allApplications = try dbQueue.read { db in
                return try Application
                    .all()
                    .filterStatuses(filteredStatuses)
                    .filterBySearch(searchQuery)
                    .including(required: Application.status.aliased(statusAlias))
                    .order(sql: sortQuery)
                    .asRequest(of: ApplicationInfo.self)
                    .fetchAll(db)
            }
        } catch {
            print("Non-fatal error (returning empty list of ApplicationInfos): \(error)")
        }
        
        return allApplications
    }
    
    /// Retrieves all statues stored in the database, ordered by their `pickerPriority`.
    ///
    /// - Returns: List of all application statuses in the database.
    func getAllStatuses() -> [Status] {
        var allStatuses: [Status] = []
        do {
            try dbQueue.read { db in
                allStatuses = try Status
                    .order {$0.pickerPriority.desc}
                    .fetchAll(db)
            }
        }
        catch {
            print("Non-fatal error (returning empty list of Statuses): \(error)")
        }
        return allStatuses
    }
    
    /// Retrieves a status from the database based on its ID.
    ///
    /// - Returns: The Status associated with ID, or nil if the status ID could not be found.
    func getStatus(_ id: Int64) -> Status? {
        return try? dbQueue.read { db in
            try Status.filter {$0.id == id}.fetchOne(db)
        }
    }
    
    /// Adds or updates an application in the database.
    ///
    /// - Parameter application: The new/existing application, whose values will be set to the database, using the `application.id` as its primary key.
    func setApplication(_ application: Application) throws {
        try dbQueue.write { db in
            let request = Application.filter { $0.id == application.id }
            let applicationIsNew = try request.isEmpty(db)
            
            if (applicationIsNew) {
                try application.insert(db)
            } else {
                try application.update(db)
            }
        }
    }
    
    /// Removes an application from the database.
    ///
    /// - Parameter application: The application to delete.
    func deleteApplication(_ application: Application) throws {
        try dbQueue.write { db in
            try application.delete(db)
        }
    }
    
    /// Returns a Combine publisher for the database's list of Application objects.
    ///
    /// - Returns: Publisher that produces a list of Applications whenever the database is updated.
    func getApplicationObservationPublisher() -> DatabasePublishers.Value<[Application]> {
        let observation = ValueObservation.tracking(Application.fetchAll)
        return observation.publisher(in: dbQueue)
    }
    
    /// Adds default statuses to the database, if the Status table is empty.
    func checkAndAddDefaultStatuses() {
        do {
            try dbQueue.write { db in
                let count = try Status.fetchCount(db)
                if (count == 0) {
                    var defaults = Status.defaults
                    for i in (0 ..< defaults.count) {
                        try defaults[i].insert(db)
                    }
                }
            }
        }
        catch {
            print("ERROR when checking for Statuses/adding defaults in the database: \(error)")
        }
    }

    /// Initializes the singleton database, opening a connection.
    private static func makeShared() -> LocalDatabase {
        do {
            // From the GRDB documentation: https://swiftpackageindex.com/groue/grdb.swift/v7.5.0/documentation/grdb/databaseconnections
            
            // Open/create the file for the database.
            let fileManager = FileManager.default
            let appSupportURL = try fileManager.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let directoryURL = appSupportURL.appendingPathComponent("LocalDatabase", isDirectory: true)
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
            
            let databaseURL = directoryURL.appendingPathComponent("db.sqlite")
            
            // Open a connection to the database.
            let dbQueue = try DatabaseQueue(path: databaseURL.path)

            // Setup the singleton object.
            let database = try LocalDatabase(dbQueue)
            database.checkAndAddDefaultStatuses()
            return database
        }
        catch {
            fatalError("Error initializing database: \(error)")
        }
    }
    
    private init(_ databaseQueue: DatabaseQueue) throws {
        self.dbQueue = databaseQueue
        try migrator.migrate(self.dbQueue)
    }
    
}

extension DerivableRequest<Application> {
    /// Selects only applications with a statusId in the given list, or all statuses if the list is empty.
    ///
    /// - Parameter statuses: List of statusIds to show. Leave empty to show all statuses.
    func filterStatuses(_ statuses: [Int64]) -> Self {
        guard statuses.count > 0 else {
            return self
        }
        let idList = statuses.map { idNumber in
            return "\(idNumber)"
        }.joined(separator: ",")
        return filter(sql: "statusId IN (\(idList))")
    }
    
    func filterBySearch(_ toSearch: String) -> Self {
        guard toSearch.count > 0 else {
            return self
        }
        
        let sql = "companyName LIKE '%\(toSearch)%' OR positionTitle LIKE '%\(toSearch)%'"
        return filter(sql: sql)
    }
}
