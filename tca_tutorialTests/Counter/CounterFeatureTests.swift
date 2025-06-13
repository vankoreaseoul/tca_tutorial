//
//  CounterFeatureTests.swift
//  CounterFeatureTests
//
//  Created by Heawon Seo on 6/12/25.
//

import Testing
import ComposableArchitecture

@testable import tca_tutorial

@MainActor
struct CounterFeatureTests {

    @Test
    func basics() async {
        let store = TestStore(initialState: CounterFeature.State()) { CounterFeature() }
        
        await store.send(.INCREMENT_BTN_TAPPED) {
            $0.count = 1
        }
        await store.send(.DECREMENT_BTN_TAPPED) {
            $0.count = 0
        }
    }
    
    @Test
    func timer() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.TOGGLE_TIMER_BTN_TAPPED) {
            $0.isTimerRunning = true
        }
        
        await clock.advance(by: .seconds(1))
        
        await store.receive(\.TIMER_TICK) {
            $0.count = 1
        }
        
        await store.send(.TOGGLE_TIMER_BTN_TAPPED) {
            $0.isTimerRunning = false
        }
    }
    
    @Test
    func numberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }
        
        await store.send(.FACT_BTN_TAPPED) {
            $0.isLoading = true
        }
        
        await store.receive(\.FACT_RESPONSE) {
            $0.isLoading = false
            $0.fact = "\($0.count) is a good number."
        }
    }

}
