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
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(store.contacts) { contact in
                    NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
                        HStack(spacing: 0) {
                            Text(contact.name)
                            
                            Spacer()
                            
                            Button {
//                                store.send(.DELETE_BTN_TAPPED(contact.id))
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                            
                        }
                    }
                    .buttonStyle(.borderless)
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
        } destination: { store in
            ContactDetailView(store: store)
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
