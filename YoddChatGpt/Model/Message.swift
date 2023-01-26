//
//  Message.swift
//  YoddChatGpt
//
//  Created by Ale on 25/01/23.
//

import Foundation

struct TemporaryMessage : Hashable {
    var body : String
    var sender : Sender
    var timeStamp = Date()
    var id = UUID()
    
}

enum Sender {
    case bot, user
}

enum MessageType {
    case text, error
}
