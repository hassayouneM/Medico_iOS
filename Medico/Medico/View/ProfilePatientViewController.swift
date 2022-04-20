//
//  ProfilePatientViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class ProfilePatientViewController: UIViewController {

    
    //var
    
    var user : User?
    
    //outlets
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var assistantNameLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var EmergencyPhoneLabel: UILabel!
    @IBOutlet weak var bloodTypelabel: UILabel!
    @IBOutlet weak var assistantEmailLabel: UILabel!
    
    
    //actions
    
    
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()

        initializePage()
        // Do any additional setup after loading the view.
    }
    

    func initializePage() {
        
        UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
            [self] success, result in self.user = result
            
            nameLabel.text = result?.name
            assistantEmailLabel.text = result?.assistant_email
            adresseLabel.text = result?.address
            EmergencyPhoneLabel.text = String(Int(result?.emergency_num ?? 0))
            bloodTypelabel.text = result?.blood_type
            
            
        }
        
    }
   

}
