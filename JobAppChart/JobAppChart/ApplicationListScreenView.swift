//
//  ApplicationListScreenView.swift
//  JobAppChart
//
//  Created by Alex on 5/1/25.
//

import SwiftUI
import UserNotifications

struct ApplicationListScreenView: View {
    @State var show = true
    @State var showNewApplicationModal = false
    var body: some View {
        NavigationStack(){
            ZStack {
                Color(#colorLiteral(red: 0.9321114421, green: 1, blue: 0.9600206017, alpha: 1)).ignoresSafeArea()
                VStack{
                    Text("Applications")
                        .font(.title)
                    
                        .padding(.horizontal)
                    ApplicationItemListView()
                        .navigationDestination(for: ApplicationItemViewModel.self) { itemVM in
                            ApplicationEditorView(vm: ApplicationEditorViewModel(toEdit: itemVM.model))
                        }
                }
                Button {
                    showNewApplicationModal = true
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add Entry")
                    }
                    .padding(10)
                    .background(
                        Rectangle()
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    )
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .sheet(isPresented: $showNewApplicationModal) {
                    ApplicationEditorView()
                }

        }

   }
}

#Preview {
    ApplicationListScreenView()
}
