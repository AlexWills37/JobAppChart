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
    
    @StateObject var vm = ApplicationItemListViewModel()
    
    var body: some View {
        Button("Add Test Entry") {
            vm.addItem()
        }
        ScrollView {

            // Spacers surrounding the list help to stop the gradient mask from hiding the first and last elements.
            Spacer()
                .frame(height: gradientSpacerSize)
            // View Model contains a list of ApplicationItem View Models to display with ApplicationItem views
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
