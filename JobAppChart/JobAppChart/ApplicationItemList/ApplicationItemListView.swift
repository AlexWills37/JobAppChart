//
//  ApplicationItemListView.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import SwiftUI
import SwiftData

struct ApplicationItemListView: View {
    let gradientSpacerSize = 70.0
    let storageService = LocalStorageService.shared
    
    @StateObject var vm = ApplicationItemListViewModel()
    
    var body: some View {
        Button("Hi") {
//            modelContext.insert(ApplicationItem(positionTitle: "HIEHI"))
        }
        Button("Test") {
//            do {
//                let i = try modelContext.fetch(FetchDescriptor<ApplicationItem>()).count
//                print("Found \(i) things in the view")
//            } catch {}
            vm.addItem()
        }
//        ForEach(tests) { entry in
//            Text("\(entry.positionTitle)")
//                .frame(width: 100, height: 50)
//                .border(.blue)
//        }
        ScrollView {

            // Spacers surrounding the list help to stop the gradient mask from hiding the first and last elements.
            Spacer()
                .frame(height: gradientSpacerSize)
            LazyVStack(spacing: 0){
                ForEach(vm.itemsToShow) { itemViewModel in
                    ApplicationItemView(vm: itemViewModel)
                }
            }
            .border(.black, width:3)
            .cornerRadius(3)
            Spacer()
                .frame(height: gradientSpacerSize)

        }
        .mask(
            LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: UnitPoint(x: 0.5, y: 0.9), endPoint: .bottom)
        )
        .mask(
            LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: .top)
        )
    }
}

#Preview {
    ApplicationItemListView()
}
