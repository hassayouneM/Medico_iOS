//
//  ForgetPassVerificationViewController.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import UIKit

class ForgetPassVerificationViewController: UIViewController {
    
    //var
    var data : ForgetPassViewController.MotDePasseOublieData?
    var compteur: Int?
    var compteurTimer : Timer?
    
    //outlets
    
    @IBOutlet weak var CodeField: UITextField!
    
    @IBOutlet weak var ResetPassBtn: UIButton!
    @IBOutlet weak var CompteurExpirationLabel: UILabel!
    //actions
    
    @IBAction func ResendBtn(_ sender: Any) {
        
        
    }
    
    @IBAction func NextBtn(_ sender: Any) {
        print(data?.code)
        if (CodeField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type the code"), animated: true)
            return
    }
        if (CodeField.text == data?.code ) {
            self.performSegue(withIdentifier: "Segue_resetPass", sender: data?.email)
        } else {
            self.present(Alert.makeAlert(titre: "Error", message: "Code incorrect"), animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NewPasswordViewController
        destination.email = data?.email
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()

        CompteurExpirationLabel.text = "60"
        compteur = 60
        startTimer()
    }
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
   
    func startTimer () {
        guard compteurTimer == nil else { return }
        
        compteurTimer =  Timer.scheduledTimer(
            timeInterval: 1,
            target      : self,
            selector    : #selector(update),
            userInfo    : nil,
            repeats     : true)
    }
    
    func stopTimer() {
        compteurTimer?.invalidate()
        compteurTimer = nil
    }
    @objc
    func update()  {
        if (compteur! > 0){
            compteur! -= 1
            CompteurExpirationLabel.text = String(compteur!)
        } else {
            stopTimer()
            ResetPassBtn.isEnabled = false
            CodeField.isUserInteractionEnabled = false
            CompteurExpirationLabel.textColor = .darkGray
            self.present(Alert.makeAlert(titre: "Warning", message: "The code exprired please restart"), animated: true)
        }
    }
    

}
