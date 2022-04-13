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
    var before_after : BorA
    var category : String?
    var name : String?
    var notif_time : Date?
    var photo : String?
    var quantity : Int?
    var until : Date?
}
