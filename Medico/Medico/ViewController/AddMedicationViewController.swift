//
//  AddMedicationViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit

class AddMedicationViewController: UIViewController {
    
    //var
    let amounts = ["1 Pill", "2 Pills", "3 Pills"]
    let periods = ["1","2", "3", "4", "5", "6", "7", "8", "9","10","11","12", "13", "14", "15", "16", "17", "18", "19","20","21","22", "23", "24", "25", "26", "27", "28", "29","30","31"]
    let times = ["Before Meal","After Meal"]
    
    
    //outlet
    @IBOutlet weak var AmountPicker: UIPickerView!
    
    @IBOutlet weak var BorA: UIPickerView!
    
    
    
    
    //action
    
    @IBAction func AddMedBtn(_ sender: Any) {
    }
    
    
    
    //function

    override func viewDidLoad() {
        super.viewDidLoad()

        AmountPicker.delegate = self
        BorA.delegate = self
        AmountPicker.dataSource  = self
        BorA.dataSource = self
        // Do any additional setup after loading the view.
    }
    


}
extension AddMedicationViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    func pickerView(_ pickerView : UIPickerView, numberOfRowsInComponent component : Int) -> Int{
        if pickerView.tag == 1{
            return amounts.count
        }else{

            return times.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return amounts[row]
        }else{

            return times[row]
        }
    }
}

