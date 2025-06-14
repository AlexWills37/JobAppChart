//
//  ApplicationItemDetailView.swift
//  JobAppChart
//
//  Created by alex w on 6/13/25.
//

import SwiftUI

struct ApplicationItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var displayEditor: Bool = false
    @StateObject var vm: ApplicationItemDetailViewModel
    var body: some View {
        VStack {
            // MARK: - Title bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.blue)
                        Text("Applications")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("Edit") {
                    displayEditor = true
                }
                .fullScreenCover(isPresented: $displayEditor) {
                    vm.refreshModelProxies()
                } content: {
                    ApplicationEditorView(vm: vm.editor)
                }
            }
            .font(.title3)
            .padding(.horizontal)
            
            // MARK: - Content
            Text(vm.pageTitle)
                .font(.title2)
            Text(vm.positionTitle)

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
//        Text("Hello \(LocalDatabase.shared.getStatus(vm.toDisplay.statusId)?.statusName ?? "na")")
    }
}

#Preview {
    
    let app: Application = LocalDatabase.shared.getAllApplicationsSorted()[0].application
    
    ApplicationItemDetailView(vm: ApplicationItemDetailViewModel(applicationModel: app))
}
