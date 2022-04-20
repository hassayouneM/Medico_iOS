//
//  ViewController.swift
//  Medico
//
//  Created by iMac on 30/3/2022.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController {

    //var
    
    //Outlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //Actions
    
    let userViewModel = UserViewModel()

    
    @IBAction func SignInBtn(_ sender: Any) {
        
        if(emailField.text!.isEmpty || passwordField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your credentials"), animated: true)
            return
        }
        
        userViewModel.signin(email: emailField.text!, password: passwordField.text!,completed: { (success, reponse) in
            
            
            if success {
                let user = reponse as! User
                print(user.isVerified!)
                if user.isVerified! {
                   
                    if user.is_assistant! {
                        self.performSegue(withIdentifier: "SegueSigninAssistant", sender: nil)
                    }else{
                        self.performSegue(withIdentifier: "SegueSigninPatient", sender: nil)

                    }
                    
                //} else {
//                    let action = UIAlertAction(title: "Réenvoyer", style: .default) { UIAlertAction in
//                        //self.reEnvoyerEmail(email: user.email)
//                    }
//                    self.present(Alert.makeActionAlert(titre: "Notice", message: "This email is not confirmed, would you like to resend the confirmation email to " + user.email! + " ?", action: action),animated: true)
//                    //self.reEnvoyerEmail(email: user.email)
//                }
            } else {
                self.present(Alert.makeAlert(titre: "Warning", message: "Email or password incorrect"), animated: true)
            }
        }
        
    }
    
    //Functions
    /*func reEnvoyerEmail(email: String?) {
        userViewModel.reEnvoyerConfirmationEmail(email: email!, completed: { (success) in
            if success {
                self.present(Alert.makeAlert(titre: "Success", message: "Confirmation email has been sent to " + email!), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not send the confirmation email"), animated: true)
            }
        })
    }*/
    )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }



}
