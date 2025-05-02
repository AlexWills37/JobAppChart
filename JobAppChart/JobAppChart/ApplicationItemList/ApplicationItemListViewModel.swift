//
//  ApplicationItemListViewModel.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//
import SwiftData
import Combine
import Foundation
import SwiftUI

class ApplicationItemListViewModel: ObservableObject {
//    @Query var allItems: [ApplicationItem]
    @Environment(\.modelContext) var modelContext
    @Published var itemsToShow: [ApplicationItemViewModel] = []
        
    var subscriptions = Set<AnyCancellable>()
    
    init() {

//        self.allItems.publisher
//            .sink { [weak self] item in
//                guard let self = self else {return}
//                self.itemsToShow.append(ApplicationItemViewModel(itemModel: item))
//                print("HOORAY")
//            }
//            .store(in: &subscriptions)
//        print(modelContext)
    }
    
    func fetchData() {
        let descriptor = FetchDescriptor<ApplicationItem>()
        do {
            let i = try modelContext.fetch(FetchDescriptor<ApplicationItem>()).count
            print("Found \(i) things in the vm")
        } catch {}
        
    }
    
//    init() {
        
//        addTestData()
//        Timer.publish(every: 0.5, on: .main, in: .common)
//            .autoconnect()
//            .sink(receiveValue: {[weak self] _ in
//                guard let self else {return}
//                self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Jelly Beans", positionTitle: "Flavor Tester", dateApplied: Date.distantPast, status: "Applied?")))
////                self.itemsToShow.append(ApplicationItemViewModel())
//                if (self.itemsToShow.count > 10) {
//                    self.subscriptions.removeFirst()
//                }
//            })
//            .store(in: &self.subscriptions)
//    }
    
//    func addTestData() {
//
//        self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Jelly Beans", positionTitle: "Flavor Tester", dateApplied: Date.distantPast, status: "Applied?")))
//        self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Google", positionTitle: "The guy who writes the search results", dateApplied: Date.distantPast, status: "Awaiting response")))
//        self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Carnival", positionTitle: "Dunk Tank Tester", dateApplied: Date.now, status: "Take home test")))
//        self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Company", positionTitle: "Job", dateApplied: Date.now, status: "Applied")))
//        self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Uber", positionTitle: "Conversation starter", dateApplied: Date.now, status: "Offer received")))
//        self.itemsToShow.append(ApplicationItemViewModel(itemModel: ApplicationItem(companyName: "Crayola", positionTitle: "Crayon Namer", dateApplied: Date.distantPast, status: "Interviewing")))
//    }
}
