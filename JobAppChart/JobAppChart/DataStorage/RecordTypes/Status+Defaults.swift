//
//  Status+Defaults.swift
//  JobAppChart
//
//  Created by alex w on 6/4/25.
//

extension Status {
    
    /// List of default statuses users can choose from.
    static var defaults: [Status] {
        return [
            Status(statusName: "Applied", color: 0x94FFA4,
                   pickerPriority: 5, displayPriority: 2),
            Status(statusName: "Interviewing", color: 0xA1FDFF,
                   pickerPriority: 4, displayPriority: 3),
            Status(statusName: "Denied", color: 0xFFA5A1,
                   pickerPriority: 3, displayPriority: -1),
            Status(statusName: "Offer Received", color: 0xE6E6E6,
                   pickerPriority: 2, displayPriority: 4),
            Status(statusName: "Offer Accepted", color: 0xF0CC60,
                   pickerPriority: 1, displayPriority: 5)
        ]
    }
}
