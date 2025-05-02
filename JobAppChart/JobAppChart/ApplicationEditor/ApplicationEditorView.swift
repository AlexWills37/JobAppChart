//
//  ApplicationEditorView.swift
//  JobAppChart
//
//  Created by Alex on 5/2/25.
//

import SwiftUI

struct ApplicationEditorView: View {
    
    @State var name: String = ""
    @State var date: Date = Date.now
    @State var status: String = "Interview"
    
    var range: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2000, month: 1, day: 1)
        return calendar.date(from: startComponents)!
        ...
        Date.now
    }()
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack {
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.blue)
                        Text("Cancel")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("Create New Application")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .lineLimit(2)
        
                Button("Save") {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .padding()
            
            TextField("Company Name", text: $name)
                .padding(.top, 20)
            Divider()
                .frame(height: 1)
                .padding(.horizontal)
            TextField("Position Title", text: $name)
                .padding(.top, 20)
            Divider()
                .frame(height: 1)
                .padding(.horizontal)
            TextField("Website Link", text: $name)
                .padding(.top, 20)
            Divider()
                .frame(height: 1)
                .padding(.horizontal)

            DatePicker("Applied on:", selection: $date, in: range, displayedComponents: [.date])
                .frame(width: 250)
                .padding(.top, 20)

            
            HStack {
                Text("Application Status:")
                Picker("Application Status", selection: $status) {
                    Text("Applied").tag("Applied")
                    Text("Interviewing").tag("Interview")
                    
                }
                .foregroundStyle(.black)
                .pickerStyle(.menu)
            }
            .padding(.top, 20)

            Text("Additional notes")
                .padding(.top, 20)
            TextEditor(text: $name)
                .border(.blue, width: 1)
                .foregroundStyle(.purple)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ApplicationEditorView()
}
