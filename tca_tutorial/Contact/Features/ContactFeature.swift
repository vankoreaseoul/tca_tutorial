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
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
        @Presents var destination: Destination.State?
    }
    
    enum Action {
        case ADD_BTN_TAPPED
        case DELETE_BTN_TAPPED(Contact.ID)
        
        case destination(PresentationAction<Destination.Action>)
        
        enum Alert: Equatable {
            case CONFIRM_DELETION(Contact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .ADD_BTN_TAPPED:
                state.destination = .ADD_CONTACT(AddContactFeature.State(contact: Contact(id: UUID(), name: "")))
                return .none
                
            case .DELETE_BTN_TAPPED(let id):
                state.destination = .ALERT(
                    AlertState {
                       TextState("Are you sure?")
                   } actions: {
                       ButtonState(role: .destructive, action: .CONFIRM_DELETION(id)) {
                           TextState("Delete")
                       }
                   }
                )
                return .none
                
            case let .destination(.presented(.ADD_CONTACT(.DELEGATE(.SAVE_CONTACT(contact))))):
                state.contacts.append(contact)
                return .none
                
            case let .destination(.presented(.ALERT(.CONFIRM_DELETION(id)))):
                state.contacts.remove(id: id)
                return .none
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
    }
}

extension ContactFeature {
    @Reducer
    enum Destination {
        case ADD_CONTACT(AddContactFeature)
        case ALERT(AlertState<ContactFeature.Action.Alert>)
    }
}

extension ContactFeature.Destination.State: Equatable {}
