//
//  ContentView.swift
//  JobAppChart
//
//  Created by Alex on 4/28/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var entries: [ApplicationItem]
    @Environment(\.modelContext) var modelContext
    
//    var body: some View {
//        Text("hi")
//        
//    }
    @State var path = [ItemDBModel]()
        
    func add() {
        let newItem = ItemDBModel(companyName: "", positionTitle: "")
        modelContext.insert(newItem)
        path = [newItem]
        print(path.description)
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = entries[index]
            modelContext.delete(item)
        }
    }
    
    var body: some View {
        Text("Hello World")
        NavigationStack(path: $path){
            List {
                
                ForEach(entries) { item in
                    NavigationLink(value: item){
                        
                        VStack{
                            
                            Text("\(item.companyName)")
                        }
                    }
                    
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("myList")
            .navigationDestination(for: ItemDBModel.self, destination: EditorTest.init)
            .toolbar {
                Button("add", action: add)
            }
        }
    }
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    ContentView()
        .modelContainer(for: ApplicationItem.self, inMemory: true)
}
