//
//  AddMedicationViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 08/04/2022.
//

import UIKit

class AddMedicationViewController: UIViewController {
    
    //var
    var med: Medicine = Medicine(_id: "", name: "", quantity: 0, photo: "", borA: "", category: "", notif_time: nil, until: nil)
 
    let amounts = ["1 Pill", "2 Pills", "3 Pills"]
    
    let times = ["Before Meal","After Meal"]
    
    
    //outlet
    @IBOutlet weak var AmountPicker: UIPickerView!
    @IBOutlet weak var BorA: UIPickerView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var untilPicker: UIDatePicker!
    @IBOutlet weak var notifPicker: UIDatePicker!
    
    
    //action
    
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
        
        //add photo
        self.med.notif_time = notifPicker.date
        self.med.borA = times[Int(BorA.selectedRow(inComponent: 0))]
        self.med.until = untilPicker.date
        self.med.quantity = Int(AmountPicker.selectedRow(inComponent: 0))
        self.med.category = categoryInput.text
        self.med.name = nameInput.text
        
        MedicineViewModel().addMedicine(id: UserDefaults.standard.string(forKey: "patientId")!, med: self.med, completed: {
            (success) in
                
                if success {
                    let alert = UIAlertController(title: "Success", message: "med has been created.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                        self.present(Alert.makeAlert(titre: "Success", message: "Medicine added successfully."), animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true)

                } else {
                    print("aaa")

                    self.present(Alert.makeAlert(titre: "Error", message: "Invalid information."), animated: true)
                }
        })
        
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

