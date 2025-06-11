//
//  CounterFeature.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/11/25.
//

import ComposableArchitecture

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State {
        var count: Int = 0
    }
    
    enum Action {
        case INCREMENT_BTN_TAPPED
        case DECREMENT_BTN_TAPPED
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .INCREMENT_BTN_TAPPED:
                state.count += 1
                return .none
                
            case .DECREMENT_BTN_TAPPED:
                state.count -= 1
                return .none
            }
        }
    }
 
    
}
