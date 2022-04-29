//
//  UserModel.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import Foundation


struct User {
    
    internal init(_id: String? = nil, name: String? = nil, birthdate: Date? = nil, address: String? = nil, assistant_email: String? = nil, blood_type: String? = nil, email: String? = nil, emergency_num: Int? = nil, is_assistant: Bool? = nil, password: String? = nil, phone: Int? = nil, photo: String? = nil, isVerified: Bool? = nil, medicines:[Medicine] = []){
        
        self._id = _id
        self.name = name
        self.birthdate = birthdate
        self.address = address
        self.assistant_email = assistant_email
        self.blood_type = blood_type
        self.email = email
        self.emergency_num = emergency_num
        self.is_assistant = is_assistant
        self.password = password
        self.phone = phone
        self.photo = photo
        self.isVerified = isVerified
        self.medicines = medicines
    }
    
    
    
    var _id : String?
    var name: String?
    var birthdate: Date?
    var address: String?
    var assistant_email: String?
    var blood_type: String?
    var email : String?
    var emergency_num : Int?
    var is_assistant : Bool?
    var password : String?
    var phone : Int?
    var photo : String?
    var isVerified : Bool?
    var medicines : [Medicine]=[]
}

