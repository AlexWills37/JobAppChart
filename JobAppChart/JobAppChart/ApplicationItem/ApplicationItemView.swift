//
//  ApplicationItemView.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import SwiftUI

struct ApplicationItemView: View {
    
    @StateObject var vm: ApplicationItemViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(vm.companyName)")
                    .font(.headline)
                Text("\(vm.positionTitle)")
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(vm.daysSinceUpdate) days ago")
                    .font(.caption)
                Text("\(vm.status)")
            }

            
        }
        .padding()
        .background(Rectangle()
            .foregroundStyle(vm.statusColor))
        .border(.separator, width: 1)
        
        .cornerRadius(3)
        .foregroundStyle(.black)
    }
}

#Preview {
    ApplicationItemView(vm: ApplicationItemViewModel(itemModel: ApplicationItem() ))
}
