//
//  ViewController.swift
//  Medico
//
//  Created by iMac on 30/3/2022.
//

import UIKit
import Alamofire
import GoogleSignIn

class SignInViewController: UIViewController {
    
    // related to signin with google
    //Google client ID
    //430426686039-3kf1jlcrffpssn8aj5k20ndaguc0877g.apps.googleusercontent.com
    let signInConfig = GIDConfiguration.init(clientID: "430426686039-3kf1jlcrffpssn8aj5k20ndaguc0877g.apps.googleusercontent.com")

    //var
    let userViewModel = UserViewModel()

    var email: String?

    let spinner = SpinnerViewController()
    
    
    //Outlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //Functions
    func reSendEmail(email: String?) {
        userViewModel.reSendConfirmationEmail(email: email!, completed: { (success) in
            if success {
                self.present(Alert.makeAlert(titre: "Success", message: "Confirmation email has been sent to " + email!), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not send the confirmation email"), animated: true)
            }
        })
    }
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
    
   
    
    //Actions
    
    @IBAction func SignInBtn(_ sender: Any) {
        
        if(emailField.text!.isEmpty || passwordField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your credentials"), animated: true)
            return
        }
        startSpinner()

        userViewModel.signin(email: emailField.text!, password: passwordField.text!,completed: { (success, reponse) in
            
            self.stopSpinner()

            if success {
                let user = reponse as! User
                print(user.isVerified!)
                print(user)
                if user.isVerified! {
                   
                    if user.is_assistant! {
                        self.performSegue(withIdentifier: "SegueSigninAssistant", sender: nil)
                    }else{
                        self.performSegue(withIdentifier: "SegueSigninPatient", sender: nil)

                    }
                    
                } else {
                    let action = UIAlertAction(title: "Resend", style: .default) { UIAlertAction in
                        self.reSendEmail(email: user.email)
                    }
                    self.present(Alert.makeActionAlert(titre: "Notice", message: "This email is not confirmed, would you like to resend the confirmation email to " + user.email! + " ?", action: action),animated: true)
                    self.reSendEmail(email: user.email)
                }
            } else {
                self.present(Alert.makeAlert(titre: "Warning", message: "Email or password incorrect"), animated: true)
            }
        })
    }
    
    
    // Sign in with google
    
    @IBAction func googleSignIn(_ sender: Any) {
        
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
            guard let user = user else { return }

            let emailAddress = user.profile?.email
            self.emailField.text = emailAddress
            
            self.performSegue(withIdentifier: "SegueSigninAssistant", sender: nil)

            //server
            //
            /*user.authentication.do { authentication, error in
                    guard error == nil else { return }
                    guard let authentication = authentication else { return }

                    let idToken = authentication.idToken
                    // Send ID token to backend (example below).
                tokenSignInExample(idToken: idToken!)
                print(idToken)
            
            }
            //FUNCTION
            func tokenSignInExample(idToken: String) {
                guard let authData = try? JSONEncoder().encode(["idToken": idToken]) else {
                    return
                }
                let url = URL(string: "http://localhost:3000/users/googlesignin")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let task = URLSession.shared.uploadTask(with: request, from: authData) { data, response, error in
                    // Handle response from your backend.
                }
                task.resume()
            }*/
    }
        
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

