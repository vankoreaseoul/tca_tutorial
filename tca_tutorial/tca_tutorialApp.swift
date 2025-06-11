//
//  tca_tutorialApp.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/11/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct tca_tutorialApp: App {
    
    static let store: StoreOf<CounterFeature> = Store(initialState: CounterFeature.State(count: 0)) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: tca_tutorialApp.store)
        }
    }
    
}
