//
//  EditProfileViewController.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    //var
    let bloodTypes = ["A+", "A-", "B+", "B-","O+","O-", "AB+","AB-"]
    
    //outlets
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var assistantNameField: UITextField!
    @IBOutlet weak var assistantEmailField: UITextField!
    
    @IBOutlet weak var bloodPicker: UIPickerView!
    
    //actions
    
    @IBAction func confirmBtn(_ sender: Any) {
    }
    
    //functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bloodPicker.dataSource = self
        bloodPicker.delegate = self
    }
    

}
extension EditProfileViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodTypes[row]
    }
}
extension EditProfileViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodTypes.count
    }
    
    
}
