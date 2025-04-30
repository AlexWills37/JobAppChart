//
//  ApplicationItemView.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import SwiftUI

struct ApplicationItemView: View {
    
    
    @StateObject var vm = ApplicationItemViewModel()
    
    var body: some View {
        HStack {
            VStack {
                Text("\(vm.companyName)")
                    .font(.headline)
                Text("\(vm.positionTitle)")
                    .font(.subheadline)
            }
            Spacer()
            Text("\(vm.status)")
            Text("\(vm.daysSinceUpdate)")

            
        }
        .padding()
        .background(Rectangle()
            .foregroundStyle(vm.statusColor))
        .border(.black, width: 3)
        .cornerRadius(3)
    }
}

#Preview {
    ApplicationItemView()
}
