//
//  ApplicationEditorView.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import SwiftUI

struct ApplicationEditorView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var vm = ApplicationEditorViewModel()
    @State var showingDeleteConfirmation = false
    @State var showingNotificationAlert = false
    
    /// Range of selectable "applied" dates, from the year 2000 to today.
    var range: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2000, month: 1, day: 1)
        return calendar.date(from: startComponents)!
        ...
        Date.now
    }()
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            
            // MARK: - Title bar
            HStack {
                Button {
                   dismiss()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.blue)
                        Text("Cancel")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(vm.title)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .lineLimit(2)
        
                HStack(spacing: 30){
                    Button {
                        vm.notificationEnbaled ? vm.toggleNotification() : showingNotificationAlert.toggle()
                    } label: {
                        Image(systemName: vm.notificationEnbaled ? "bell.circle" : "bell.slash.circle")
                            .foregroundStyle(.blue)
                            .font(.title2)
                    }
                    .alert("Follow up?", isPresented: $showingNotificationAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Enable") {
                            vm.toggleNotification()
                        }
                    } message: {
                        Text("Would you like to receive a reminder to follow up on this application 14 days after the Applied On date?")
                    }
                    .alert("Error", isPresented: $vm.notificationsNotAuthorized) {} message: {
                        Text("Notifications are not enabled. To receive notifications, please change your settings.")
                    }
                    Button("Save") {
                        vm.saveEntry()
                        dismiss()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .padding()
            
            // MARK: - Editor fields
            TextField("Company Name", text: $vm.companyName)
                .padding(.top, 20)
            Divider()
                .frame(height: 1)
                .padding(.horizontal)
            TextField("Position Title", text: $vm.positionTitle)
                .padding(.top, 20)
            Divider()
                .frame(height: 1)
                .padding(.horizontal)
            TextField("Website Link (optional)", text: $vm.websiteLink)
                .padding(.top, 20)
            Divider()
                .frame(height: 1)
                .padding(.horizontal)

            DatePicker("Applied on:", selection: $vm.dateApplied, in: range, displayedComponents: [.date])
                .frame(width: 250)
                .padding(.top, 20)

            
            HStack {
                Text("Application Status:")
                Picker("Application Status", selection: $vm.statusId) {
                    ForEach(vm.statusOptions, id: \.self.id) { status in
                        Text(status.name).tag(status.id)
                    }
                }
                .foregroundStyle(.black)
                .pickerStyle(.menu)
            }
            .padding(.vertical, 20)

            VStack(spacing: 5) {
                
                Text("Additional notes")
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $vm.notes)
                    .frame(height: 250)
                    .scrollContentBackground(.hidden)
                    .background(Color(#colorLiteral(red: 0.8952754736, green: 0.8952754736, blue: 0.8952754736, alpha: 1)))
                    .multilineTextAlignment(.leading)
                    .mask {
                        Rectangle()
                            .cornerRadius(10)
                    }
            }
            .padding(.horizontal, 30)
            
            // MARK: - Footer/delete button
            Spacer()
            Button("Delete") {
                showingDeleteConfirmation = true
            }
            .padding()
            .confirmationDialog("Delete application", isPresented: $showingDeleteConfirmation, actions: {
                Button("Delete", role: .destructive) {
                    vm.deleteEntry()
                    dismiss()
                }
                Button("Keep editing", role: .cancel) {}
            })
            .foregroundStyle(.red)
            .opacity(vm.newApplication ? 0 : 1)
        }
        .multilineTextAlignment(.center)
        .background(
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.white)
                .cornerRadius(20)
        )
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
        Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)).ignoresSafeArea()
        ApplicationEditorView()
    }
}
