//
//  ApplicationItemListViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//
import Combine
import Foundation

class ApplicationItemListViewModel: ObservableObject {
    @Published var itemsToShow: [ApplicationItemViewModel] = []
        
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        addTestData()
        Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: {[weak self] _ in
                guard let self else {return}
                self.itemsToShow.append(ApplicationItemViewModel())
                if (self.itemsToShow.count > 10) {
                    self.subscriptions.removeFirst()
                }
            })
            .store(in: &self.subscriptions)
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
