//
//  AddContactView.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    
    @Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.SET_NAME))
            
            Button("Save") { store.send(.SAVE_BTN_TAPPED) }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") { store.send(.CANCEL_BTN_TAPPED) }
            }
        }
        
        
    }
}

#Preview {
    NavigationStack {
        AddContactView(
            store: Store(
                initialState: AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
            ) {
                AddContactFeature()
            }
        )
    }
}
