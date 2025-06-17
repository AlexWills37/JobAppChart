//
//  SwiftUIView.swift
//  JobAppChart
//
//  Created by alex w on 6/9/25.
//

import SwiftUI

struct SortBarView: View {
    @StateObject var vm: SortBarViewModel
    @State var showSortBar: Bool = false
    
    var sortBar: some View {
        VStack {
            // MARK: Group/Sort
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
            
            // MARK: Status filtering
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
    
            // MARK: Text search
            TextField("Search", text: $vm.searchQuery)
                .padding(.horizontal)
                .background(
                    Capsule().foregroundStyle(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))))
                .padding(.horizontal)
        } // End of VStack
    }
    
    var body: some View {
        
        // Toggle the entire sort bar with animations
        Button {
            withAnimation {
                showSortBar.toggle()
            }
        } label: {
            HStack {
                Text("Sort and organize")
                Image(systemName: "chevron.down.circle")
                    .rotationEffect(.degrees(showSortBar ? -180 : 0))
                    .animation(.easeInOut, value: showSortBar)
                        
                Spacer()
            }
        }
        .padding(.horizontal)

        if showSortBar {
            sortBar
        }
        
        
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

/// Displays the toggle as a capsule that fills in when active.
struct CapsuleToggleStyle: ToggleStyle {
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

// Adds custom style for easy usage.
extension ToggleStyle where Self == CapsuleToggleStyle {
    static var custom: CapsuleToggleStyle {.init()}
}

#Preview {
    SortBarView(vm: SortBarViewModel())
}
