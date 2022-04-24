//
//  ForgetPassViewController.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import UIKit

class ForgetPassViewController: UIViewController {
    
    //var
    struct MotDePasseOublieData {
        var email: String?
        var code: String?
    }
    var data : MotDePasseOublieData?
    let spinner = SpinnerViewController()
    
    
    //outlets
    
    @IBOutlet weak var emailField: UITextField!
    
    
    //actions
    
    @IBAction func ResetPassBtn(_ sender: Any) {
        if (emailField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your email"), animated: true)
            return


    }
        startSpinner()
        
        data = MotDePasseOublieData(email: emailField.text, code: String(Int.random(in: 1000..<9999)))
        
        UserViewModel().forgetPassword(email: (data?.email)!, codeDeReinit: (data?.code)! ) { success in
            self.stopSpinner()
            if success {
                self.performSegue(withIdentifier: "Confirm", sender: self.data)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Email does not exist"), animated: true)
            }
        }
    


}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ForgetPassVerificationViewController
        destination.data = data
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
