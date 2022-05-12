//
//  assistantProfileViewController.swift
//  Medico
//
//  Created by Apple Esprit on 12/5/2022.
//

import UIKit

class assistantProfileViewController: UIViewController {

    //var
    var user : User?
    
    var age: Int?
    var Birthdate : Date?
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
 
    
    override func viewDidLoad() {
        super.viewDidLoad()


        initializePage()
        self.loadView()
    }
    

    func initializePage() {
        
        
        UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "patientId")!) {
            [self] success, result in self.user = result
            
            nameLabel.text = (result?.name)!
            assistantEmailLabel.text = (result?.assistant_email)!
            adresseLabel.text = (result?.address)!
            EmergencyPhoneLabel.text = String(Int((result?.emergency_num)!))
            bloodTypelabel.text = (result?.blood_type)!
            Birthdate = (result?.birthdate)!
            print("------------------date")
            print(type(of: Birthdate))
            ageLabel.text = String(Calendar.current.dateComponents([.year], from: Birthdate!, to: Date()).year!)
            
            
        }
        
    }

}
