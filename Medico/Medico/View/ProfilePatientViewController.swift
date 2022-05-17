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
    var assistant : User?
    var email=""
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
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()

        initializePage()
    }
    override func viewDidAppear(_ animated: Bool) {
        initializePage()
    }

    func initializePage() {
        
        
        ImageView.layer.borderWidth = 1
        ImageView.layer.masksToBounds = true
        ImageView.layer.borderColor = UIColor(red:18/255, green:19/255, blue:38/255, alpha: 1).cgColor
        ImageView.layer.cornerRadius = ImageView.frame.height/2
        ImageView.clipsToBounds = true;
        
        
        
        UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
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
            print(age)
            print("-------àààààààààààààà")
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
                assistantNameLabel.text = UserDefaults.standard.string(forKey: "assistantName")!
                
            }
        }
        
        
        
    }
   
}
extension UIImageView {
    func loadImge(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}
