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
                    Text(contact.name)
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
        .sheet(item: $store.scope(state: \.addContact, action: \.ADD_CONTACT)) { addContactStore in
            NavigationStack { AddContactView(store: addContactStore) }
        }
        
        
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
