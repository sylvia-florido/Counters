//
//  CountersListViewModel.swift
//  Counters
//
//  Created by Me on 22/01/21.
//

import Foundation

//struct CountersListViewModel {
//    let viewTitle: String
//    let leftButtonTitle: String
//    let leftButtonStatus: ButtonState
//}

struct CountersCellViewModel {
    let title: String
    let value: Int
    let selected: Bool
}

struct ToolBarViewModel {
    let toolbarTitle: String?
    let leftAction: (() -> Void)?
    let righttAction: (() -> Void)?
}

//enum ButtonState {
//    case enabled
//    case disabled
//    case hidden
//}


//enum NavBarStyle {
//    case listModeEnabled(leftButtonTitle: String, viewTitle: String)
//    case listModeDisabled
//    case editMode
//}


