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
            
            Button {
                store.send(.TOGGLE_TIMER_BTN_TAPPED)
            } label: {
                CardView(title: "\(store.isTimerRunning ? "Stop" : "Start") timer")
            }

            Button {
                store.send(.FACT_BTN_TAPPED)
            } label: {
                CardView(title: "Fact")
            }
            
            if store.isLoading {
                ProgressView()
                
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
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
