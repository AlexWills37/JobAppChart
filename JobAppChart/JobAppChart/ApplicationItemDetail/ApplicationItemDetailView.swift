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
        VStack(spacing: 10) {
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
                    vm.refreshApplicationModel()
                } content: {
                    ApplicationEditorView(vm: vm.editor)
                }
            }
            .font(.title3)
            .padding(.horizontal)
            
            // MARK: - Content
            Text(vm.pageTitle)
                .font(.title2)
            
            HStack{
                Text(vm.websiteLink)
            }
            
            Text("Status: \(vm.statusName)")
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(vm.statusColor)
                )
            
            // Date applied
            HStack(alignment: .top) {
                Text("Applied on")
                VStack {
                    Text(vm.dateApplied.formatted(date: .abbreviated, time: .omitted))
                    Text("(\(vm.daysSinceApplication) days ago)")
                }
            }
            
            // Notes
            VStack (alignment: .leading) {
                HStack{
                    Text("Notes")
                    Spacer()
                }
                if (vm.notes.count > 0) {
                    Text(vm.notes)
                } else {
                    Text("No notes")
                        .italic()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    
//    let app: Application = LocalDatabase.shared.getAllApplicationsSorted()[0].application
    let status: Status = Status(id: 0, statusName: "Test", color: 0xFF00FF, pickerPriority: 10, displayPriority: 10)
    let app: Application = Application(companyName: "Test Company", positionTitle: "Developer", dateApplied: Date.now, status: status, websiteLink: "google.com")
    
    ApplicationItemDetailView(vm: ApplicationItemDetailViewModel(applicationModel: app))
}
