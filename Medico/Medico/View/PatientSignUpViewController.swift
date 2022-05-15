//
//  PatientSignUpViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class PatientSignUpViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    //var
    let bloodTypes = ["A+", "A-", "B+", "B-","O+","O-", "AB+","AB-"]
    var currentPhoto : UIImage?

    var user: User?
    
    //outlets
    
    @IBOutlet weak var addImageUser: UIButton!
    @IBOutlet weak var AssistantEmailField: UITextField!
    @IBOutlet weak var EmmergencyNumberField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var bloodPlicker: UIPickerView!
    @IBOutlet weak var AddressField: UITextField!
    @IBOutlet weak var PhotoUser: UIImageView!
    //action
    
    @IBAction func changephoto(_ sender: Any) {
        showActionSheet()

    }
    
    @IBAction func signupBtn(_ sender: Any) {
        
        //EMPTY FIELD VERFICATION
        if (AssistantEmailField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your assistant email"), animated: true)
            return
        }
        
        if (EmmergencyNumberField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your emmergency number"), animated: true)
            return
        }
        
        
        if (AddressField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your address"), animated: true)
            return
        }
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Warning", message: "Choose a profile photo"), animated: true)
            return
        }
        //add photo
        self.user?.birthdate = birthDatePicker.date
        self.user?.address = AddressField.text
        self.user?.assistant_email = AssistantEmailField.text
        self.user?.blood_type = bloodTypes[Int(bloodPlicker.selectedRow(inComponent: 0))]
        self.user?.emergency_num = Int(EmmergencyNumberField.text!)
        print(type(of: self.user?.emergency_num))
        
        UserViewModel().signup(user: self.user!, uiImage: currentPhoto!) { (success) in
            
            if success {
                print("deee")
                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "Segue_patient_signup", sender: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
                //UserDefaults.standard.set(self.user?.email, forKey: "email")
            } else {
                print("aaa")

                self.present(Alert.makeAlert(titre: "Error", message: "Invalid information."), animated: true)
            }
        }
    }
        
    
    //function
    override func viewDidLoad() {
        super.viewDidLoad()

        bloodPlicker.dataSource = self
        bloodPlicker.delegate = self
    }
   
    func camera()
    {
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)

    }
  
  
  func gallery()
  {

      let myPickerControllerGallery = UIImagePickerController()
      myPickerControllerGallery.delegate = self
      myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
      myPickerControllerGallery.allowsEditing = true
      self.present(myPickerControllerGallery, animated: true, completion: nil)

  }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            
            return
        }
        
        currentPhoto = selectedImage
        PhotoUser.image = selectedImage
//        addImageButton.isHidden = true
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){

        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
        { action -> Void in
            self.camera()
        }
        actionSheetController.addAction(saveActionButton)

        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }

}
extension PatientSignUpViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodTypes.count
    }
    
    
}
extension PatientSignUpViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodTypes[row]
    }
}
