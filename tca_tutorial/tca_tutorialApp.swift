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
    
    static let store: StoreOf<AppFeature> = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: tca_tutorialApp.store)
        }
    }
    
}
