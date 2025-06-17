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
        var path: StackState<ContactDetailFeature.State> = .init()
    }
    
    enum Action {
        case ADD_BTN_TAPPED
//        case DELETE_BTN_TAPPED(Contact.ID)
        
        case destination(PresentationAction<Destination.Action>)
        case path(StackActionOf<ContactDetailFeature>)
        
        @CasePathable
        enum Alert: Equatable {
            case CONFIRM_DELETION(Contact.ID)
        }
    }
    
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .ADD_BTN_TAPPED:
                state.destination = .ADD_CONTACT(AddContactFeature.State(contact: Contact(id: self.uuid(), name: "")))
                return .none
                
//            case .DELETE_BTN_TAPPED(let id):
//                state.destination = .ALERT(.deleteConfirmation(id: id))
//                return .none
                
            case .destination(let childAction):
                switch childAction {
                case .presented(.ADD_CONTACT(.DELEGATE(.SAVE_CONTACT(let contact)))):
                    state.contacts.append(contact)
                    return .none
                    
                case .presented(.ALERT(.CONFIRM_DELETION(let id))):
                    state.contacts.remove(id: id)
                    return .none
                    
                default:
                    return .none
                }
                
            case .path(let stackAction):
                switch stackAction {
                case .element(id: let id, action: .DELEGATE(.DO_DELETE)):
                    guard let detailState = state.path[id: id] else { return .none }
                    state.contacts.remove(id: detailState.contact.id)
                    return .none
                    
                default:
                    return .none
                }
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
        .forEach(\.path, action: \.path) {
            ContactDetailFeature()
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

extension AlertState where Action == ContactFeature.Action.Alert {
    static func deleteConfirmation(id: UUID) -> Self {
        Self {
            TextState("Are you sure?")
        } actions: {
            ButtonState(role: .destructive, action: .CONFIRM_DELETION(id)) {
                TextState("Delete")
            }
        }
    }
}
