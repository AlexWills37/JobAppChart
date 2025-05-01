//
//  EditorTest.swift
//  JobAppChart
//
//  Created by Alex on 5/1/25.
//

import SwiftUI
import SwiftData

struct EditorTest: View {
    @Bindable var item: ItemDBModel
    
    
    
    var body: some View {
        Form {
            TextField("Company", text: $item.companyName)
        }
        .navigationTitle("Editor")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    do {
        let test = ItemDBModel(companyName: "JOHNSOON", positionTitle: "Moe")
        return EditorTest(item: test).modelContainer(for: ItemDBModel.self, inMemory: true)
    }
}
