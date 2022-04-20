//
//  Medicine.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import Foundation

enum BorA : String {
    case B = "Before Meal"
    case A = "After Meal"
}
struct Medecine {
    var Before_after : BorA
    var Category : String?
    var Name : String?
    var Notif_time : Date?
    var Photo : String?
    var Quantity : Int?
    var Until : Date?
}
