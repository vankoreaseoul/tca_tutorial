//
//  Views.swift
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
            .background(.black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
