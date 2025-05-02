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
    @State var notes: String =  "(optional)"
    
    
    
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
            TextField("Website Link (optional)", text: $name)
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
            .padding(.vertical, 20)

            VStack(spacing: 5) {
                
                Text("Additional notes")
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $notes)
                    .frame(height: 250)
//                    .border(.black, width: 1)
                    .scrollContentBackground(.hidden)
                    .background(Color(#colorLiteral(red: 0.8952754736, green: 0.8952754736, blue: 0.8952754736, alpha: 1)))
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 30)
            Spacer()
        }
        .multilineTextAlignment(.center)
        .background(
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.white)
                .cornerRadius(20)
        )
    }
}

#Preview {
    ZStack {
        Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)).ignoresSafeArea()
        ApplicationEditorView()
    }
}
