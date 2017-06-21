//
//  MessageHandler.swift
//  tictactoe
//
//  Created by Maite Mañana on 5/29/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import SwiftMessages

enum messageType {
    case SUCCESS
    case ERROR
    case WARNING
}

class MessageHandler {

    class func showMessage(title: String, body: String, type: messageType) {
        SwiftMessages.sharedInstance.show {
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureContent(title: title, body: body)
            view.button?.isHidden = true
            view.configureDropShadow()
            
            var config = SwiftMessages.Config()
            config.duration = .seconds(seconds: 5)
            switch type {
            case messageType.SUCCESS:
                view.configureTheme(.success)
                break
            case messageType.ERROR:
                view.configureTheme(.error)
                break
            case messageType.WARNING:
                view.configureTheme(.warning)
                break
            }
            
            
            
            return view
        }
    }
}


