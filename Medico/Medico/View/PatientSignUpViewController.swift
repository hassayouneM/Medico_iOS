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
    
    var user: User?
    
    //outlets
    
    
    @IBOutlet weak var AssistantEmailField: UITextField!
    @IBOutlet weak var EmmergencyNumberField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var bloodPlicker: UIPickerView!
    @IBOutlet weak var AddressField: UITextField!
    //action
    
    
    
    @IBAction func signupBtn(_ sender: Any) {
        
        //EMPTY FIELD VERFICATION
        if (AssistantEmailField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your assistant email"), animated: true)
            return
        }
        
        if (EmmergencyNumberField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your emmergency number"), animated: true)
            return
        }
        
        
        if (AddressField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your address"), animated: true)
            return
        }
        
        //add photo
        self.user?.birthdate = birthDatePicker.date
        self.user?.address = AddressField.text
        self.user?.assistant_email = AssistantEmailField.text
        self.user?.blood_type = bloodTypes[Int(bloodPlicker.selectedRow(inComponent: 0))]
        self.user?.emergency_num = Int(EmmergencyNumberField.text!)
        
        UserViewModel().signup(user: self.user!,  completed: { (success) in
            
            if success {
                //print(self.user?._id)
                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "signup_patient_segue", sender: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
                //UserDefaults.standard.set(self.user?.email, forKey: "email")
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
            }
            
        })
        
    }
        
        
        
        

    
    
    
    //function
    override func viewDidLoad() {
        super.viewDidLoad()

        bloodPlicker.dataSource = self
        bloodPlicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let blood_type_selected = bloodTypes[row] as String
//    }

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
