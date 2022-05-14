//
//  PatientSettingsViewController.swift
//  Medico
//
//  Created by Mac-Mini_2021 on 14/05/2022.
//

import UIKit

class PatientSettingsViewController: UIViewController {

    
    //var
    
    //outlet
    
    
    @IBOutlet weak var themeLabel: UILabel!
    //action
    
    @IBAction func themeSwitch(_ sender: UISwitch) {
        if #available(ios 13.0 , *){
            let window = UIApplication.shared.windows.first
            if sender.isOn{
                window?.overrideUserInterfaceStyle = .dark
                themeLabel.text = "Dark Mode"
            }else{
                themeLabel.text = "Light Mode"

                window?.overrideUserInterfaceStyle = .light}
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        performSegue(withIdentifier: "logoutPsegue", sender: nil)

    }
    
    //function
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
