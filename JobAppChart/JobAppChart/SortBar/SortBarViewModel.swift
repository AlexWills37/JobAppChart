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
}


