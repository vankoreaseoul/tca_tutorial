//
//  ContactView.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import SwiftUI
import ComposableArchitecture

struct ContactView: View {
    
    @Bindable var store: StoreOf<ContactFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    HStack(spacing: 0) {
                        Text(contact.name)
                        
                        Spacer()
                        
                        Button {
                            store.send(.DELETE_BTN_TAPPED(contact.id))
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }

                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.ADD_BTN_TAPPED)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(item: $store.scope(state: \.destination?.ADD_CONTACT, action: \.destination.ADD_CONTACT)) { addContactStore in
            NavigationStack { AddContactView(store: addContactStore) }
        }
        .alert($store.scope(state: \.destination?.ALERT, action: \.destination.ALERT))
        
        
    }
}

#Preview {
    ContactView(
        store: Store(
            initialState: ContactFeature.State(
                contacts: [
                    Contact(id: UUID(), name: "Blob"),
                    Contact(id: UUID(), name: "Blob Jr"),
                    Contact(id: UUID(), name: "Blob Sr")
                ]
            )
        ) {
            ContactFeature()
        }
    )
}
