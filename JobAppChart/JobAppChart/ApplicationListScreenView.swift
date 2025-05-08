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
    var body: some View {
        NavigationStack(){
            ZStack {
                Color(#colorLiteral(red: 0.9321114421, green: 1, blue: 0.9600206017, alpha: 1)).ignoresSafeArea()
                VStack{
                    Button("Requresst Permss") {
                        UNUserNotificationCenter.current()
                            .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if (success) {
                                    print("Access granted")
                                }
                                else if let error {
                                    print(error.localizedDescription)
                                }
                                
                            }
                    }
                    Button("Schedule notif") {
                        let content = UNMutableNotificationContent()
                        content.title = "NOTIFICATRION"
                        content.subtitle = "whassup"
                        content.sound = .default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                    }
                    
                    Text("Applications")
                        .font(.title)
                    
                        .padding(.horizontal)
                    ApplicationItemListView()
                        .navigationDestination(for: ApplicationItemViewModel.self) { itemVM in
                            ApplicationEditorView(vm: ApplicationEditorViewModel(toEdit: itemVM.model))
                        }
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

   }
}

#Preview {
    ApplicationListScreenView()
}
