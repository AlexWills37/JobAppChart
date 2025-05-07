//
//  StatusList.swift
//  JobAppChart
//
//  Created by Alex on 5/6/25.
//

import SwiftUI
import Combine
class StatusList {
    // ApplicationEditorViewModel needs a list of strings (or status objects)
    // ItemViewModel needs a Color 
    
    static let shared = StatusList()
    
    /// Application statuses and their associated colors.
    ///
    /// Integer used to order the keys when displaying a dropdown of status options.
    var statusToColorMap: [String:(Color, Int)] = [
        "Applied":(Color(#colorLiteral(red: 0.6699355245, green: 1, blue: 0.7128309608, alpha: 1)), 0),
        "Interviewing":(Color(#colorLiteral(red: 0.5695464015, green: 0.9899430871, blue: 1, alpha: 1)), 1),
        "Denied":(Color(#colorLiteral(red: 1, green: 0.6282176375, blue: 0.6115702987, alpha: 1)), 2),
        "Offer Received":(Color(#colorLiteral(red: 0.9112802148, green: 0.9112802148, blue: 0.9112802148, alpha: 1)), 3),
        "Offer Accepted":(Color(#colorLiteral(red: 0.9414841533, green: 0.7747927308, blue: 0.3097402155, alpha: 1)), 4),
    ]
    
    private init() {
    }
    
    /// Returns the SwiftUI.Color for a given status.
    ///
    /// - Parameter status: The application status.
    /// - Returns: The status's associated Color, or a default of Gray if the status is not recognized.
    func getStatusColor(_ status: String) -> Color {
        let color = statusToColorMap[status]?.0 ?? Color.gray
        return color
    }
    
    func getOrderedStatuses() -> [String] {
        let sortedKeys = statusToColorMap.keys.sorted { lhs, rhs in
            return statusToColorMap[lhs]!.1 < statusToColorMap[rhs]!.1
        }
        return sortedKeys
    }
}
