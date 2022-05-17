//
//  DefaultSignUpViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class DefaultSignUpViewController: UIViewController {

    //var
    var name: String?
    var email: String?
    var password: String?
    var is_assistant: Bool?
    var phone_number: Int?
    var userViewModel = UserViewModel()
    var user = User()
    
    
    
    //Outlets
    @IBOutlet weak var isAssistantSwitch: UISwitch!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    @IBOutlet weak var CPassField: UITextField!
    @IBOutlet weak var PhoneNumberField: UITextField!
    
    
    @IBOutlet weak var logo: UIImageView!
    
    //action
    @IBAction func nextbtn(_ sender: UIButton) {
        
        sender.flash()
        
        //Empty Fields Verfication
        if (nameField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your name")
            return
        }
        
        if (emailField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your email")
            return
        }else if (emailField.text?.contains("@") == false){
            makeAlert(titre: "Warning", message: "Please type your email correctly")
            return
        }
        
        if (PassField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your password")
            return
        }
        
        if (CPassField.text == "") {
            makeAlert(titre: "Warning", message: "Please type the password confirmation")
            return
        }
        
        if (PassField.text != CPassField.text) {
            makeAlert(titre: "Warning", message: "Password and confirmation don't match")
            return
        }
        if (PhoneNumberField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your phone number")
            return
        }
        //INPUT CONFIRMATION DONE UP
        
        if (isAssistantSwitch.isOn ){
            user.is_assistant = true
        } else {
            user.is_assistant = false
        }
        
        user.name = nameField.text
        user.email = emailField.text
        user.password  = PassField.text
        user.phone = Int(PhoneNumberField.text!)
        //print(type(of: user.phone))
        user.is_assistant = isAssistantSwitch.isOn
        print(user.is_assistant)
        user.birthdate = Date.now
        user.photo = ""
        user.address = ""
        user.assistant_email = ""
        user.blood_type = ""
        user.emergency_num = 0
        //user.medicines = []
        if isAssistantSwitch.isOn {
            
            UserViewModel().signup(user: user, uiImage: logo.image!,  completed: { (success) in
                
                if success {
                    
                    let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                        self.performSegue(withIdentifier: "Segue_Signup_Signin", sender: self.user)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true)
                } else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
                }
                
            })
            
        }else{
            
            
            
            performSegue(withIdentifier: "nextSignup_segue", sender: user)
            
            
        }
        
    }
   
    //function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "nextSignup_segue" {
            
            let destination = segue.destination as! PatientSignUpViewController
            destination.user = user
        }
    }
    
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
