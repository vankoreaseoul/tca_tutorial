//
//  CounterView.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/11/25.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        
        VStack(spacing: 4) {
            CardView(title: "\(store.count)")
            
            HStack(spacing: 4) {
                Button {
                    store.send(.DECREMENT_BTN_TAPPED)
                } label: {
                    CardView(title: "-")
                }
                
                Button {
                    store.send(.INCREMENT_BTN_TAPPED)
                } label: {
                    CardView(title: "+")
                }
            }
            
        }
        
        
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
