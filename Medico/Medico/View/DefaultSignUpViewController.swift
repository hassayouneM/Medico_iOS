//
//  DefaultSignUpViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class DefaultSignUpViewController: UIViewController {

    //var
    
    
    
    //Outlets
    @IBOutlet weak var isAssistantSwitch: UISwitch!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    @IBOutlet weak var CPassField: UITextField!
    @IBOutlet weak var PhoneNumberField: UITextField!
    
    
    
    //action
    @IBAction func nextbtn(_ sender: Any) {
        if isAssistantSwitch.isOn {
            performSegue(withIdentifier: "signup_assistant_segue", sender: isAssistantSwitch.isOn)
        }else{
            performSegue(withIdentifier: "nextSignup_segue", sender: isAssistantSwitch.isOn)
        }
        
    }
   
    //function
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
