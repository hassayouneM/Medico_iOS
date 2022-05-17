//
//  AddMedicationViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit

class AddMedicationViewController: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    //var
    var med: Medicine = Medicine(_id: "", name: "", quantity: 0, photo: "", borA: "", category: "", notif_time: nil, until: nil)
    var currentPhoto : UIImage?
    
    let amounts = ["1 Pill", "2 Pills", "3 Pills"]
    
    let times = ["Before Meal","After Meal"]
    
    
    //outlet
    @IBOutlet weak var AmountPicker: UIPickerView!
    @IBOutlet weak var BorA: UIPickerView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var untilPicker: UIDatePicker!
    @IBOutlet weak var notifPicker: UIDatePicker!

    @IBOutlet weak var addImageMed: UIButton!
    @IBOutlet weak var PhotoMed: UIImageView!
    
    //action
    
    @IBAction func changephoto(_ sender: Any) {
        showActionSheet()
    }
    @IBAction func AddMedBtn(_ sender: Any) {
        
        //EMPTY FIELD VERFICATION
        if (nameInput.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please the name"), animated: true)
            return
        }
        
        if (categoryInput.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please the category"), animated: true)
            return
        }
        if (currentPhoto == nil){
            self.present(Alert.makeAlert(titre: "Warning", message: "Choose a profile photo"), animated: true)
            return
        }

        self.med.notif_time = notifPicker.date
        self.med.borA = times[Int(BorA.selectedRow(inComponent: 0))]
        print(self.med.borA)
        self.med.until = untilPicker.date
        self.med.quantity = Int(AmountPicker.selectedRow(inComponent: 0))
        self.med.category = categoryInput.text
        self.med.name = nameInput.text
    
                
        MedicineViewModel().addMedicine(id: UserDefaults.standard.string(forKey: "patientId")!, med: self.med,uiImage: currentPhoto!) { (success) in
                if success {
                    let alert = UIAlertController(title: "Success", message: "med has been created.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) 
                    alert.addAction(action)
                    self.present(alert, animated: true)

                } else {
                    print("aaa")

                    self.present(Alert.makeAlert(titre: "Error", message: "Invalid information."), animated: true)
                }
        }
        
    }
    
    
    
    //function

    override func viewDidLoad() {
        super.viewDidLoad()

        AmountPicker.delegate = self
        BorA.delegate = self
        AmountPicker.dataSource  = self
        BorA.dataSource = self
        // Do any additional setup after loading the view.
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
        PhotoMed.image = selectedImage
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
extension AddMedicationViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    func pickerView(_ pickerView : UIPickerView, numberOfRowsInComponent component : Int) -> Int{
        if pickerView.tag == 1{
            return amounts.count
        }else{

            return times.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return amounts[row]
        }else{

            return times[row]
        }
    }
}

