//
//  Item.swift
//  JobAppChart
//
//  Created by Alex on 4/28/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
