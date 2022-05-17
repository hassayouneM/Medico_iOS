//
//  AssistantSettingsViewController.swift
//  Medico
//
//  Created by Mac2021 on 13/5/2022.
//

import UIKit

class AssistantSettingsViewController: UIViewController {

    
    //var
    
    
    //outlets
    
    @IBOutlet weak var themeLabel: UILabel!
    
    //action
    
    @IBAction func themeSwitch(_ sender: UISwitch) {
        
        if #available(ios 13.0 , *){
            let window = UIApplication.shared.windows.first
            if sender.isOn{
                themeLabel.text = "Dark Mode"

                window?.overrideUserInterfaceStyle = .dark
            }else{
                themeLabel.text = "Light Mode"

                window?.overrideUserInterfaceStyle = .light}
        }
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        //UserDefaults.standard.set("", forKey: "tokenConnexion")
               performSegue(withIdentifier: "logoutsegue", sender: nil)
    }
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
