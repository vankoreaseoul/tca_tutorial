//
//  ContactDetailFeature.swift
//  tca_tutorial
//
//  Created by Heawon Seo on 6/16/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        let contact: Contact
    }
    
    enum Action {
        case DELETE_BTN_TAPPED
        
        case ALERT(PresentationAction<Alert>)
        case DELEGATE(Delegate)
        
        enum Alert {
            case CONFIRM_DELETION
        }
        enum Delegate {
            case DO_DELETE
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .DELETE_BTN_TAPPED:
                state.alert = .confirmDeletion
                return .none
                
            case .ALERT(let childAction):
                switch childAction {
                case .presented(.CONFIRM_DELETION):
                    return .run { send in await send(.DELEGATE(.DO_DELETE)) }
                    
                default:
                    return .none
                }
                
            case .DELEGATE:
                return .run { _ in await self.dismiss() }
            }
        }
        .ifLet(\.$alert, action: \.ALERT)
        
    }
}

extension AlertState where Action == ContactDetailFeature.Action.Alert {
    
    static let confirmDeletion = Self {
        TextState("Are you sure?")
    } actions: {
        ButtonState(role: .destructive, action: .CONFIRM_DELETION) {
            TextState("Delete")
        }
    }
    
}
