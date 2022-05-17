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
    
    var bloodIndex : Int?
    var user : User?
    
    //outlets
    @IBOutlet weak var assistantEmailField: UITextField!
    
    @IBOutlet weak var em_numField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bloodPicker: UIPickerView!
    
    //actions
    
    @IBAction func confirmBtn(_ sender: Any) {
        
        print("Edited profile")
        
        if (nameField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your name"), animated: true)
            return
        }
        
        if (addressField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your address"), animated: true)
            return
        }
        
        if (em_numField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your emergency number"), animated: true)
            return
        }
        
        if (addressField.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your assistant's address"), animated: true)
            return
        }
        
    //    viewDidAppear(<#T##animated: Bool##Bool#>)
      //  diddis
        
        //user?.idPhoto = ""
        
        user?.name = nameField.text
        user?.assistant_email = assistantEmailField.text
        user?.address = addressField.text
        user?.emergency_num = Int(em_numField.text!)
        user?.blood_type = bloodTypes[Int(bloodPicker.selectedRow(inComponent: 0))]
        user?.birthdate = datePicker.date
        
        UserViewModel().updateProfile(user: user!, methode: .put, completed:{
            (success) in
            print (success)
            if success {
            }else{
            }
        } )
        
        _ = navigationController?.popViewController(animated: true)
      
    }
    
    //functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializePage()
        
        bloodPicker.dataSource = self
        bloodPicker.delegate = self
    }
    
    func initializePage() {
          
            UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
                [self] success, result in self.user = result
                
                        print("patient : ------------")
                        print(UserDefaults.standard.string(forKey: "id"))
                print(user)
            
                nameField.text = user?.name
                assistantEmailField.text = user?.assistant_email!
                addressField.text = user?.address!
                em_numField.text = String(Int((user?.emergency_num)!))
                datePicker.date = (user?.birthdate)!
                bloodIndex = bloodTypes.firstIndex(of: (user?.blood_type)!)
                bloodPicker.selectRow(bloodIndex!, inComponent:0 , animated: true)
                
            }
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
