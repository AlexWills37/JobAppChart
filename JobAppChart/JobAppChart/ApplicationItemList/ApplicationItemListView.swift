//
//  ApplicationItemListView.swift
//  JobAppChart
//
//  Created by Alex on 4/30/25.
//

import SwiftUI

struct ApplicationItemListView: View {
    let gradientSpacerSize = 70.0
    @State private var scrollPosition: CGPoint = .zero
    var body: some View {
        ScrollView {

            LazyVStack(spacing: 0){
                // Spacers surrounding the list help to stop the gradient mask from hiding the first and last elements.
                Spacer()
                    .frame(height: gradientSpacerSize)
                ForEach(Range(1...30)) { _ in
                    ApplicationItemView()
                        .border(.blue)
                }
                Spacer()
                    .frame(height: gradientSpacerSize)
            }

        }
        .mask(
            LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: UnitPoint(x: 0.5, y: 0.9), endPoint: .bottom)
        )
        .mask(
            LinearGradient(colors: [Color.black, Color.black.opacity(0)], startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: .top)
        )
    }
}

#Preview {
    ApplicationItemListView()
}
