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
        VStack {
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
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(vm.allStatuses) { status in
                        
                        Toggle(isOn: binding(for: status.id!))
                        {
                            Text(status.statusName)
                        }
                        .toggleStyle(.custom)
                    }
                }
                .padding()
            }
    
            TextField("Search", text: $vm.searchQuery)
                .padding(.horizontal)
                .background(
                    Capsule().foregroundStyle(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))))
                .padding(.horizontal)
        } // End of VStack
        
    } // End of body
    
    // Solution for making a binding to a dictionary's values: https://dcordero.me/posts/binding-a-swift-dictionary-to-swiftui.html
    private func binding(for key: Int64) -> Binding<Bool> {
        return Binding(get: {
            return self.vm.statusFilters[key] ?? false
        }, set: {
            self.vm.statusFilters[key] = $0
        })
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
