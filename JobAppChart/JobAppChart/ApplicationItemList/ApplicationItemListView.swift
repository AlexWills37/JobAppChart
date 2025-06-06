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
        ZStack {
            VStack {
                ScrollView {

                    // Spacers surrounding the list help to stop the gradient mask from hiding the first and last elements.
                    Spacer()
                        .frame(height: gradientSpacerSize)
                    // View Model contains a list of ApplicationItem View Models to display with ApplicationItem views
                    LazyVStack(spacing: 10){
                        
                        ForEach(vm.groupedItemsToShow, id: \.self) { group in
                            
                            LazyVStack(spacing: 0) {
                                ForEach(group) { itemViewModel in
                                    NavigationLink(value: itemViewModel) {
                                        ApplicationItemView(vm: itemViewModel)
                                    }
                                }
                            }
                            .border(.black, width:2)
                            .cornerRadius(3)
                        }
                    }
                    Spacer()
                        .frame(height: gradientSpacerSize)

                }
                .mask(
                    LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: UnitPoint(x: 0.5, y: 0.9), endPoint: .bottom)
                )
                .mask(
                    LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: .top)
                )
                // End of scroll view
            } // End of VStack
                
        } // End of ZStack
    }
}

#Preview {
    ApplicationItemListView()
}
