//
//  ApplicationListScreenView.swift
//  JobAppChart
//
//  Created by Alex on 5/1/25.
//

import SwiftUI

struct ApplicationListScreenView: View {
    @State var show = true
    var body: some View {
        NavigationStack(){
            ZStack {
                Color(#colorLiteral(red: 0.9321114421, green: 1, blue: 0.9600206017, alpha: 1)).ignoresSafeArea()
                VStack{
                    
                    Text("Applications")
                        .font(.title)
                    
                        .padding(.horizontal)
                    ApplicationItemListView()
//                        .navigationDestination(for: ApplicationItemViewModel.self) { itemVM in
//                             ApplicationEditorView()
//                        }
                }
                NavigationLink(value: ApplicationItem()){
                    
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
                .navigationDestination(for: ApplicationItem.self) { itemModel in
                    return ApplicationEditorView()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                
                
            }

        }
        .navigationDestination(isPresented: $show) {
            ApplicationEditorView()
        }

   }
}

#Preview {
    ApplicationListScreenView()
}
