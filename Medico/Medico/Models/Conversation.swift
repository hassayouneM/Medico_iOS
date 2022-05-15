//
//  Conversation.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 15/05/2022.
//

import Foundation

struct Conversation {
    
    internal init(_id: String? = nil, dernierMessage: String, dateDernierMessage: Date, envoyeur: User, recepteur: User) {
        self._id = _id
        self.dernierMessage = dernierMessage
        self.dateDernierMessage = dateDernierMessage
        self.envoyeur = envoyeur
        self.recepteur = recepteur
    }
    
    var _id : String?
    var dernierMessage : String
    var dateDernierMessage : Date
    
    // relations
    var envoyeur : User
    var recepteur : User
}
