//
//  PatientSignUpViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class PatientSignUpViewController: UIViewController {

    //var
    let bloodTypes = ["A+", "A-", "B+", "B-","O+","O-", "AB+","AB-"]
    
    //outlets
    
    @IBOutlet weak var bloodPlicker: UIPickerView!
    //action
    
    @IBAction func signupBtn(_ sender: Any) {
        performSegue(withIdentifier: "signup_patient_segue", sender: true)
    }
    
    
    
    //function
    override func viewDidLoad() {
        super.viewDidLoad()

        bloodPlicker.dataSource = self
        bloodPlicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    

}
extension PatientSignUpViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodTypes.count
    }
    
    
}
extension PatientSignUpViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodTypes[row]
    }
}
