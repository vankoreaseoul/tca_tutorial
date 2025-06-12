//
//  AppFeature.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }
    
    enum Action {
        case TAB_1(CounterFeature.Action)
        case TAB_2(CounterFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.TAB_1) {
            CounterFeature()
        }
        
        Scope(state: \.tab2, action: \.TAB_2) {
            CounterFeature()
        }
        
        Reduce { state, action in
            return .none
        }
        
    }
    
}
