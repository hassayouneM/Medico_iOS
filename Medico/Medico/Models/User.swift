//
//  UserModel.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import Foundation

enum Blood_types : String {
    case AP = "A+"
    case AN = "A-"
    case BP = "B+"
    case BN = "B-"
    case ABP = "AB+"
    case ABN = "AB-"
    case OP = "O+"
    case ON = "O-"
}
struct User {
    var name: String?
    var age: Int?
    var adresse: String?
    var assistant_email: String?
    var blood_type: Blood_types
    var email : String?
    var emergency_num : String?
    var is_assistant : Bool?
    var password : String?
    var phone : Int?
    var photo : String?
    
}

