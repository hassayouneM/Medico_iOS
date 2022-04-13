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
    var Name: String?
    var Age: Int?
    var Adresse: String?
    var Assistant_email: String?
    var Blood_type: Blood_types
    var Email : String?
    var Emergency_num : String?
    var Is_assistant : Bool?
    var Password : String?
    var Phone : Int?
    var Photo : String?
    
}

