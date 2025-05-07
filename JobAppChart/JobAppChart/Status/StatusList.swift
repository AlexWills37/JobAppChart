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
    
    
    var statusToColorMap: [String:Color] = [
        "Applied":Color(#colorLiteral(red: 0.6699355245, green: 1, blue: 0.7128309608, alpha: 1)),
        "Interviewing":Color(#colorLiteral(red: 0.5695464015, green: 0.9899430871, blue: 1, alpha: 1)),
        "Denied":Color(#colorLiteral(red: 1, green: 0.6282176375, blue: 0.6115702987, alpha: 1)),
        "Offer Received":Color(#colorLiteral(red: 0.9112802148, green: 0.9112802148, blue: 0.9112802148, alpha: 1)),
        "Offer Accepted":Color(#colorLiteral(red: 0.9414841533, green: 0.7747927308, blue: 0.3097402155, alpha: 1)),
    ]
    
    
    private init() {
    }
    
    func getStatusColor(_ status: String) -> Color {
        let color = statusToColorMap[status] ?? Color.gray
        return color
    }
}
