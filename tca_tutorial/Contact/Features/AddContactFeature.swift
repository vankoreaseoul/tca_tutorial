//
//  AddContactFeature.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/12/25.
//

import ComposableArchitecture

@Reducer
struct AddContactFeature {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case CANCEL_BTN_TAPPED
        case SAVE_BTN_TAPPED
        
        case SET_NAME(String)
        
        case DELEGATE(Delegate)
        
        @CasePathable
        enum Delegate: Equatable {
            case CLOSE
            case SAVE_CONTACT(Contact)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .CANCEL_BTN_TAPPED:
                return .run { send in await send(.DELEGATE(.CLOSE)) }
                
            case .SAVE_BTN_TAPPED:
                return .run { [contact = state.contact] send in await send(.DELEGATE(.SAVE_CONTACT(contact))) }
                
            case .SET_NAME(let name):
                state.contact.name = name
                return .none
                
            case .DELEGATE:
                return .run { _ in await self.dismiss() }
            }
            
        }
    }
    
}
