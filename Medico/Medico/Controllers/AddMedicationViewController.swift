//
//  AddMedicationViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit

class AddMedicationViewController: UIViewController {
    
    //var
    let amounts = ["1 Pill", "2 Pills"]
    let periods = ["1","2", "3", "4", "5", "6", "7", "8", "9","10","11","12", "13", "14", "15", "16", "17", "18", "19","20","21","22", "23", "24", "25", "26", "27", "28", "29","30","31"]
    let times = ["Before Breakfast","After Breakfast","Before Lunch", "After Lunch", "Before Dinner","After Dinner"]
    
    //outlet
    @IBOutlet weak var AmountPicker: UIPickerView!
    @IBOutlet weak var periodPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    
    
    
    //action
    
    
    
    
    //function

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

