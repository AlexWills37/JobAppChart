//
//  ApplicationItemListViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//
import Combine
import Foundation

class ApplicationItemListViewModel {
    @Published var itemsToShow: [ApplicationItemViewModel] = []
        
    
    
    init() {
        addTestData()
    }
    
    func addTestData() {
        self.itemsToShow.append(contentsOf: [
            ApplicationItemViewModel(companyName: "Arthrex", positionTitle: "Software Engineer", websiteLink: "", status: "Applied", dateApplied: Date().addingTimeInterval(-1 * 60 * 60 * 24 * 20)),
            ApplicationItemViewModel(companyName: "Peanut Factory", positionTitle: "Peanut Manager", websiteLink: "", status: "Applied", dateApplied: Date().addingTimeInterval(-1 * 60 * 60 * 24 * 21)),
            ApplicationItemViewModel(companyName: "Google", positionTitle: "Person who writes the search results", websiteLink: "", status: "Applied", dateApplied: Date().addingTimeInterval(-1 * 60 * 60 * 24 * 20)),
            ApplicationItemViewModel(companyName: "Zoo", positionTitle: "Penguin Feeder", websiteLink: "", status: "Applied", dateApplied: Date().addingTimeInterval(-1 * 60 * 60 * 24 * 20)),
            ApplicationItemViewModel(companyName: "Space Station", positionTitle: "Chef", websiteLink: "", status: "Applied", dateApplied: Date().addingTimeInterval(-1 * 60 * 60 * 24 * 20)),
        ])
    }
}
