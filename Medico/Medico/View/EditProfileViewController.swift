//
//  EditProfileViewController.swift
//  Medico
//
//  Created by iMac on 12/4/2022.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    //var
    let bloodTypes = ["A+", "A-", "B+", "B-","O+","O-", "AB+","AB-"]
    var currentPhoto : UIImage?

    var bloodIndex : Int?
    var user : User?
    
    //outlets
    @IBOutlet weak var UserPhoto: UIImageView!
    @IBOutlet weak var assistantEmailField: UITextField!
    
    @IBOutlet weak var changePhoto: UIButton!
    @IBOutlet weak var em_numField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bloodPicker: UIPickerView!
    
    //actions
    
    @IBAction func changePhoto(_ sender: Any) {
        showActionSheet()
    }
    @IBAction func confirmBtn(_ sender: Any) {
        
        print("Edited profile")
        
        if (nameField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your name"), animated: true)
            return
        }
        
        if (addressField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your address"), animated: true)
            return
        }
        
        if (em_numField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your emergency number"), animated: true)
            return
        }
        
        if (addressField.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your assistant's address"), animated: true)
            return
        }

        
        user?.name = nameField.text
        user?.assistant_email = assistantEmailField.text
        user?.address = addressField.text
        user?.emergency_num = Int(em_numField.text!)
        user?.blood_type = bloodTypes[Int(bloodPicker.selectedRow(inComponent: 0))]
        user?.birthdate = datePicker.date
        currentPhoto = UserPhoto.image
        UserViewModel().updateProfile(user: user!, uiImage: currentPhoto!, completed:{
            (success) in
            print (success)
            if success {
            }else{
            }
        } )
        
        _ = navigationController?.popViewController(animated: true)
      
    }
    
    //functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializePage()
        
        bloodPicker.dataSource = self
        bloodPicker.delegate = self
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
        UserPhoto.image = selectedImage
//        addImageButton.isHidden = true
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(){

        print("oooooooooooo")
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
    func initializePage() {
        UserPhoto.layer.borderWidth = 1
        UserPhoto.layer.masksToBounds = true
        UserPhoto.layer.borderColor = UIColor(red:18/255, green:19/255, blue:38/255, alpha: 1).cgColor
        UserPhoto.layer.cornerRadius = UserPhoto.frame.height/2
        UserPhoto.clipsToBounds = true;

            UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
                [self] success, result in self.user = result
                
                        print("patient : ------------")
                        print(UserDefaults.standard.string(forKey: "id"))
                print(user)
                let url = URL(string : HOST_POST_URL+"/uploads/"+(user?.photo)!)
                UserPhoto.loadImge(withUrl: url!)
                nameField.text = user?.name
                assistantEmailField.text = user?.assistant_email!
                addressField.text = user?.address!
                em_numField.text = String(Int((user?.emergency_num)!))
                datePicker.date = (user?.birthdate)!
                bloodIndex = bloodTypes.firstIndex(of: (user?.blood_type)!)
                bloodPicker.selectRow(bloodIndex!, inComponent:0 , animated: true)
                
            }
}
}
extension EditProfileViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodTypes[row]
    }
}
extension EditProfileViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodTypes.count
    }
    
    
}
