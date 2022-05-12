//
//  HomePatientViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit
import Alamofire

class HomePatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var
    var user : User?
    var medicine : Medicine?
    
    var meds : [Medicine] = []
    
    //outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //functions

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let TVCell = tableView.dequeueReusableCell(withIdentifier: "PCell")!
        let cv = TVCell.contentView
        //let MedImg = cv.viewWithTag(1) as! UIImageView
        let name = cv.viewWithTag(2) as! UILabel
        let category = cv.viewWithTag(3) as! UILabel
        let time = cv.viewWithTag(4) as! UILabel
        let BorA = cv.viewWithTag(5) as! UILabel
//        MedImg.image = UIImage(named: meds[indexPath.row])
       
        medicine = meds[indexPath.row]
        name.text = medicine?.name!
        category.text = medicine?.category!
        time.text = DateUtils.formatFromDateForDisplayHoursMin(date: (medicine?.notif_time) as! Date)
        BorA.text = medicine?.borA!
        return TVCell
    }
    
    func fetchData() {
        
        UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
            [self] success, result in self.user = result
            
            meds = result!.medicines
          
            tableView.reloadData()
        }
       
    }
}
