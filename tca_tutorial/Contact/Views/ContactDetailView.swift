//
//  ContactDetailView.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/16/25.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    
    @Bindable var store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        
        Form {
            Button("Delete") {
                store.send(.DELETE_BTN_TAPPED)
            }
        }
        .navigationTitle(Text(store.contact.name))
        .alert($store.scope(state: \.alert, action: \.ALERT))
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(
            store: Store(
                initialState: ContactDetailFeature.State(
                    contact: Contact(id: UUID(), name: "Blob")
                )
            ) {
                ContactDetailFeature()
            }
        )
    }
}
