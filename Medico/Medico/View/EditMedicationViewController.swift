//
//  EditMedicationViewController.swift
//  Medico
//
//  Created by iMac on 15/4/2022.
//

import UIKit

class EditMedicationViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    //var
    var currentPhoto : UIImage?

    var med : Medicine?
    let amounts = ["1 Pill", "2 Pills", "3 Pills"]
    let periods = ["1","2", "3", "4", "5", "6", "7", "8", "9","10","11","12", "13", "14", "15", "16", "17", "18", "19","20","21","22", "23", "24", "25", "26", "27", "28", "29","30","31"]
    let times = ["Before Meal","After Meal"]
    var  boraIndex : Int = 0
    
    //outlet
    @IBOutlet weak var EditAmountPicker: UIPickerView!
    
    @IBOutlet weak var changeMEd: UIButton!
    @IBOutlet weak var medPhoto: UIImageView!
    @IBOutlet weak var EditBorA: UIPickerView!
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var categoryInput: UITextField!
    
    @IBOutlet weak var notifPicker: UIDatePicker!
    @IBOutlet weak var untilPicker: UIDatePicker!
    //action

    
    @IBAction func changeMedImage(_ sender: Any) {
        showActionSheet()
        
    }
    @IBAction func confirmBtn(_ sender: Any) {
        
        //EMPTY FIELD VERFICATION
        if (nameInput.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please the name"), animated: true)
            return
        }
        
        if (categoryInput.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please the category"), animated: true)
            return
        }
        //add photo
        self.med?.notif_time = notifPicker.date
        self.med?.borA = times[Int(EditBorA.selectedRow(inComponent: 0))]
        self.med?.until = untilPicker.date
        self.med?.quantity = Int(EditAmountPicker.selectedRow(inComponent: 0))
        self.med?.category = categoryInput.text
        self.med?.name = nameInput.text
        
        MedicineViewModel().updateMedicine(med: self.med!, completed: {
            (success) in
                if success {

                    let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                        self.present(Alert.makeAlert(titre: "Success", message: "Medicine updated successfully."), animated: true)
                    }
                    
                } else {
                    print("aaa")
                    self.present(Alert.makeAlert(titre: "Error", message: "Invalid information."), animated: true)
                }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializePage()
        
        EditBorA.delegate = self
        EditBorA.dataSource = self
        EditAmountPicker.delegate = self
        EditAmountPicker.dataSource = self
        
        print(med)
    }
    
    func initializePage() {
          
          print("===================")
        print(med)
            nameInput.text = med?.name
            categoryInput.text = med?.category
            untilPicker.date = (med?.until)!
            notifPicker.date = (med?.notif_time)!
        let url = URL(string : HOST_POST_URL+"/uploads/"+(med?.photo)!)
        //ImageView.loadImage(withurl :url)
        medPhoto.loadImge(withUrl: url!)
        
        //EditAmountPicker.selectRow((med?.quantity)! - 1 , inComponent : 0 , animated : true)
        print("---------------")
        print(med?.borA)
        boraIndex = times.firstIndex(of: (med?.borA)!)!
            EditBorA.selectRow(boraIndex, inComponent:0 , animated: true)
                
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
        medPhoto.image = selectedImage
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
extension EditMedicationViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
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
