//
//  Message.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 15/05/2022.
//

import Foundation
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind

}
