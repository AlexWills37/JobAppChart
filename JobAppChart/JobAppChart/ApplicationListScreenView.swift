//
//  ApplicationListScreenView.swift
//  JobAppChart
//
//  Created by Alex on 5/1/25.
//

import SwiftUI

struct ApplicationListScreenView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9321114421, green: 1, blue: 0.9600206017, alpha: 1)).ignoresSafeArea()
            VStack{
                
                Text("Applications")
                    .font(.title)
                
                    .padding(.horizontal)
                ApplicationItemListView()
            }
        }
        
   }
}

#Preview {
    ApplicationListScreenView()
}
