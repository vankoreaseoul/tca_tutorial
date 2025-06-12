//
//  AppView.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            Tab("Counter 1", image: "") {
                CounterView(bgColor: .blue, store: store.scope(state: \.tab1, action: \.TAB_1))
            }
            
            Tab("Counter 2", image: "") {
                CounterView(bgColor: .green, store: store.scope(state: \.tab2, action: \.TAB_2))
            }
        }
        
        
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {
        AppFeature()
    }))
}
