//
//  ContactFeature.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ContactFeature {
    
    @ObservableState
    struct State {
        var contacts: IdentifiedArrayOf<Contact> = []
        
        @Presents var addContact: AddContactFeature.State?
    }
    
    enum Action {
        case ADD_BTN_TAPPED
        
        case ADD_CONTACT(PresentationAction<AddContactFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .ADD_BTN_TAPPED:
                state.addContact = AddContactFeature.State(contact: Contact(id: UUID(), name: ""))
                return .none
                  
            case .ADD_CONTACT(let childrenAction):
                switch childrenAction {
                case let .presented(.DELEGATE(.SAVE_CONTACT(contact))):
                    state.contacts.append(contact)
                    return .none
                    
                default:
                    return .none
                }
                
            }
        }
        .ifLet(\.$addContact, action: \.ADD_CONTACT) {
            AddContactFeature()
        }
    }
}
