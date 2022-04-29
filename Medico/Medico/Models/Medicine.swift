//
//  Medicine.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import Foundation


struct Medicine {
    
    internal init(_id:String? = nil,name: String? = nil,quantity: Int? = nil,photo: String? = nil,borA: String? = nil,category: String? = nil,notif_time: Date? = nil,until: Date? = nil){
        
        self._id = _id
        self.name = name
        self.quantity = quantity
        self.photo = photo
        self.borA = borA
        self.category = category
        self.notif_time  = notif_time
        self.until = until
    }

    
    
    var _id : String?
    var name : String?
    var quantity : Int?
    var photo : String?
    var borA : String?
    var category : String?
    var notif_time : Date?
    var until : Date?
}
