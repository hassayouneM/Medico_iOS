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
    var email=""
    var assistant : User?

    var age: Int?
    var Birthdate : Date?
    //outlets
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var EmergencyPhoneLabel: UILabel!
    @IBOutlet weak var bloodTypelabel: UILabel!
    @IBOutlet weak var assistantEmailLabel: UILabel!
    
    
    @IBOutlet weak var assistantName: UILabel!
    //actions
 
    
    override func viewDidLoad() {
        super.viewDidLoad()


        initializePage()
        self.loadView()
    }
    

    func initializePage() {
        
        
        ImageView.layer.borderWidth = 1
        ImageView.layer.masksToBounds = true
        ImageView.layer.borderColor = UIColor(red:18/255, green:19/255, blue:38/255, alpha: 1).cgColor
        ImageView.layer.cornerRadius = ImageView.frame.height/2
        ImageView.clipsToBounds = true;
        
        
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
            print(result?.photo)
            
            
            let url = URL(string : HOST_POST_URL+"/uploads/"+(result?.photo)!)
            //ImageView.loadImage(withurl :url)
            ImageView.loadImge(withUrl: url!)

            email = (result?.assistant_email)!
            print(email)
            
            UserViewModel().getAssistant(email: email) {
                
                [self] success, result in self.assistant = result
                print(email)
                print("___________________")
                print(UserDefaults.standard.string(forKey: "assistantName")!)
                assistantName.text = UserDefaults.standard.string(forKey: "assistantName")!
                
            }
            
        }
        
    }

}
