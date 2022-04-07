//
//  PatientSignUpViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class PatientSignUpViewController: UIViewController {

    //var
    
    
    //outlets
    
    //action
    
    @IBAction func signupBtn(_ sender: Any) {
        performSegue(withIdentifier: "signup_patient_segue", sender: true)
    }
    
    
    
    //function
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
