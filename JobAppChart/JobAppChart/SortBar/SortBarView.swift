//
//  SwiftUIView.swift
//  JobAppChart
//
//  Created by alex w on 6/9/25.
//

import SwiftUI

struct SortBarView: View {
    @StateObject var vm: SortBarViewModel
    
    var body: some View {
        HStack {
            Toggle(isOn: $vm.groupByStatus) {
                Text("Group by status")
            }
            .toggleStyle(.custom)
            
            Text("Sort by")
            Picker(selection: $vm.sortOrder, label: Text("Sort by...")) {
                Text("Oldest first").tag(SortOption.oldestFirst)
                Text("Newest first").tag(SortOption.newestFirst)
            }
            .background(
                Rectangle().foregroundStyle(.white)
                    .clipShape(.capsule)
            )
            .overlay(Capsule().stroke(.blue, lineWidth: 2))
        }
        .padding(.horizontal)
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
                .lineLimit(1)
                .foregroundStyle(configuration.isOn ? .white : .blue)
        }
        .background(
            configuration.isOn ? .blue : .white
        )
        .clipShape(.capsule)
        .overlay(
            Capsule()
                .stroke(.blue, lineWidth: 2)
        )
        .buttonStyle(.bordered)
    }
}

extension ToggleStyle where Self == CustomToggleStyle {
    static var custom: CustomToggleStyle {.init()}
}

#Preview {
    SortBarView(vm: SortBarViewModel())
}
