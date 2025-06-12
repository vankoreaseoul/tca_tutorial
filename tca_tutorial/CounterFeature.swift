//
//  CounterFeature.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/11/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State {
        var count: Int = 0
        var fact: String? = nil
        var isLoading: Bool = false
        var isTimerRunning: Bool = false
    }
    
    enum Action {
        case INCREMENT_BTN_TAPPED
        case DECREMENT_BTN_TAPPED
        case FACT_BTN_TAPPED
        case TOGGLE_TIMER_BTN_TAPPED
        
        case FACT_RESPONSE(String)
        case TIMER_TICK
    }
    
    enum CancelID {
        case TIMER
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .INCREMENT_BTN_TAPPED:
                state.count += 1
                state.fact = nil
                return .none
                
            case .DECREMENT_BTN_TAPPED:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .FACT_BTN_TAPPED:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.FACT_RESPONSE(fact))
                }
                
            case .FACT_RESPONSE(let fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .TOGGLE_TIMER_BTN_TAPPED:
                state.isTimerRunning.toggle()
                
                if state.isTimerRunning {
                    return .run { send in
                        while (true) {
                            try await Task.sleep(for: .seconds(1))
                            await send(.TIMER_TICK)
                        }
                    }
                    .cancellable(id: CancelID.TIMER)
                    
                } else {
                    return .cancel(id: CancelID.TIMER)
                }
                
            case .TIMER_TICK:
                state.count += 1
                state.fact = nil
                return .none
            }
        }
    }
 
    
}
