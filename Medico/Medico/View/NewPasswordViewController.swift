//
//  NewPasswordViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 24/04/2022.
//

import UIKit

class NewPasswordViewController: UIViewController {

    
    //var
    var email: String?
    let spinner = SpinnerViewController()
    
    //outets
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var CPassField: UITextField!
    
    
    //action
    
    @IBAction func resetpass(_ sender: Any) {
        if (passField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your new password"), animated: true)
            return
        }
        
        if (CPassField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type the confirmation of your new password"), animated: true)
            return
        }
        
        if (passField.text != CPassField.text) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Passwords should match"), animated: true)
            return
        }
        
        startSpinner()
    
        UserViewModel().changepassword(email: email!, newPassword: CPassField.text!, completed: { success in
            self.stopSpinner()
            if success {
                let action = UIAlertAction(title: "Return", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "Segue_PassChanged", sender: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Your password has been changed", action: action), animated: true)
            }else{
                self.present(Alert.makeAlert(titre: "Error", message: "Could not change your password"), animated: true)
            }
        })
    }
    
    //function
    func startSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func stopSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SignInViewController
        destination.email = self.email

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

