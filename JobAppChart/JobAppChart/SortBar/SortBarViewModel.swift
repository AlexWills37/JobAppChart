//
//  SortBarViewModel.swift
//  JobAppChart
//
//  Created by alex w on 6/9/25.
//
import Combine

class SortBarViewModel: ObservableObject {
    @Published var groupByStatus: Bool = true
    @Published var sortOrder: SortOption = .newestFirst
    
    var allStatuses: [Status] = []
    @Published var statusFilters: [Int64: Bool] = [:]
    
    init() {
        self.allStatuses = LocalDatabase.shared.getAllStatuses()
        for status in self.allStatuses {
            self.statusFilters[status.id!] = false
        }
    }
    
    
    
}


