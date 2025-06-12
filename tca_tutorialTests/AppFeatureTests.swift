//
//  AppFeatureTests.swift
//  tca_tutorialTests
//
//  Created by Heawon Seo on 6/12/25.
//

import ComposableArchitecture
import Testing

@testable import tca_tutorial

@MainActor
struct AppFeatureTests {
    
    @Test
    func incrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.TAB_1.INCREMENT_BTN_TAPPED) {
            $0.tab1.count = 1
        }
    }
    
}
