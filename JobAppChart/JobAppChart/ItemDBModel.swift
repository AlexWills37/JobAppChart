//
//  ItemDBModel.swift
//  JobAppChart
//
//  Created by Alex on 5/1/25.
//

import Foundation
import Combine
import SwiftData

@Model class ItemDBModel: ObservableObject {
    var id = UUID()
    var companyName: String = ""
    var positionTitle: String = ""
    
    init(companyName: String, positionTitle: String) {
        
        self.companyName = companyName
        self.positionTitle = positionTitle

    }
}
