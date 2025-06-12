//
//  CardView.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/11/25.
//

import SwiftUI

struct CardView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .padding()
            .background {
                Color.black.opacity(0.5)
                    .background(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
