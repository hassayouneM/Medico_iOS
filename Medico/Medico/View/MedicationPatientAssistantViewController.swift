//
//  MedicationPatientAssistantViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class MedicationPatientAssistantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    //var
    var user:User?
    var medicine : Medicine?
    var meds : [Medicine] = []
    var categories = ["Blood pressure Medicine", "Blood sugar Medicine", "Blood sugar Medicine","Blood pressure Medicine","Blood sugar Medicine","Blood pressure Medicine"]
    var frequencies = ["20h00 / 1 pill", "08h00 / 2 pills", "20h00 / 1 pill", "08h00 / 2 pills", "11h30 / 1 pill", "11h30 / 1 pill" ]
    let times = ["Before Meal","After Meal","Before Meal", "After Meal", "After Meal","After Meal"]
    //outlets
//    pId = "627b7823d0432afebda1c293"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //actions
    
    
    //functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let TVCell = tableView.dequeueReusableCell(withIdentifier: "PCell", for: indexPath)
        let cv = TVCell.contentView
        //let MedImg = cv.viewWithTag(1) as! UIImageView
        let name = cv.viewWithTag(2) as! UILabel
        let category = cv.viewWithTag(3) as! UILabel
        let time = cv.viewWithTag(4) as! UILabel
        let BorA = cv.viewWithTag(5) as! UILabel
        
        
        //MedImg.image = UIImage(named: meds[indexPath.row])
        medicine = meds[indexPath.row]
        name.text = medicine?.name!
        category.text = medicine?.category!
        time.text = DateUtils.formatFromDateForDisplayHoursMin(date: (medicine?.notif_time) as! Date)
        BorA.text = medicine?.borA!
        
        return TVCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditMedSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditMedSegue" {
            let index = sender as! IndexPath
            let destination = segue.destination as! EditMedicationViewController
            destination.med = meds[index.row]
        }
        
       
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
                delete(indexPath)
        }
    }
    
    func fetchData() {
        print("------------pId")
        print(UserDefaults.standard.string(forKey: "patientId"))
        UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "patientId")!) {
            [self] success, result in self.user = result
            
            meds = result!.medicines
          
            tableView.reloadData()
        }
       
    }
    
    func delete(index :IndexPath){
        
        

        MedicineViewModel().deleteMedicine(pId : "627b7823d0432afebda1c293", mId: meds[index.row]._id! , completed: {
            (success) in

                if success {
                    print("pId------------------")
                //    print(self.pId)

                    let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                        self.present(Alert.makeAlert(titre: "Success", message: "Medicine deleled successfully."), animated: true)
                    }

                    //UserDefaults.standard.set(self.user?.email, forKey: "email")
                } else {


                    self.present(Alert.makeAlert(titre: "Error", message: "Invalid information."), animated: true)
                }
        }

        )
    }
}

