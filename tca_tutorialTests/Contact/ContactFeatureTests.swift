//
//  ContactFeatureTests.swift
//  tca_tutorialTests
//
//  Created by Heawon Seo on 6/16/25.
//

import Foundation
import ComposableArchitecture
import Testing

@testable import tca_tutorial

@MainActor
struct ContactFeatureTests {
    
    @Test
    func addFlow() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.ADD_BTN_TAPPED) {
            $0.destination = .ADD_CONTACT(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                )
            )
        }
        await store.send(\.destination.ADD_CONTACT.SET_NAME, "Blob Jr.") {
            $0.destination.modify(\.ADD_CONTACT) { $0.contact.name = "Blob Jr." }
        }
        await store.send(\.destination.ADD_CONTACT.SAVE_BTN_TAPPED)
        
        await store.receive(\.destination.ADD_CONTACT.DELEGATE.SAVE_CONTACT, Contact(id: UUID(0), name: "Blob Jr.")) {
            $0.contacts = [Contact(id: UUID(0), name: "Blob Jr.")]
        }
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }
    
    @Test
    func addFlowNonExhaustive() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
        await store.send(.ADD_BTN_TAPPED)
        await store.send(\.destination.ADD_CONTACT.SET_NAME, "Blob Jr.")
        await store.send(\.destination.ADD_CONTACT.SAVE_BTN_TAPPED)
        await store.skipReceivedActions()
        store.assert {
            $0.contacts = [Contact(id: UUID(0), name: "Blob Jr.")]
            $0.destination = nil
        }
        
    }
    
    @Test
    func deleteContact() async {
        let store = TestStore(
            initialState:
                ContactFeature.State(
                    contacts: [
                        Contact(id: UUID(0), name: "Blob"),
                        Contact(id: UUID(1), name: "Blob Jr.")
                    ]
                )
        ) {
            ContactFeature()
        }
        
        await store.send(.DELETE_BTN_TAPPED(UUID(1))) {
            $0.destination = .ALERT(.deleteConfirmation(id: UUID(1)))
        }
        await store.send(\.destination.ALERT.CONFIRM_DELETION, UUID(1)) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob")
            ]
            $0.destination = nil
        }
    }
    
}
