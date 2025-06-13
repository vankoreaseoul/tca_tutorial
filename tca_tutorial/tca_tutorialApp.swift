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
    
    static let counterStore: StoreOf<CounterAppFeature> = Store(initialState: CounterAppFeature.State()) {
        CounterAppFeature()
            ._printChanges()
    }
    
    static let contactStore: StoreOf<ContactFeature> = Store(initialState: ContactFeature.State()) {
        ContactFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
//            CounterAppView(store: tca_tutorialApp.counterStore)
            ContactView(store: tca_tutorialApp.contactStore)
        }
    }
    
}
