//
//  HomePatientViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class HomePatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //var
    var meds = ["pill4", "pill1","pill2", "pill3","pill4", "pill1" ]
    var categories = ["Blood pressure Medicine", "Blood sugar Medicine", "Blood sugar Medicine","Blood pressure Medicine","Blood sugar Medicine","Blood pressure Medicine"]
    var frequencies = ["20h00 / 1 pill", "08h00 / 2 pills", "20h00 / 1 pill", "08h00 / 2 pills", "11h30 / 1 pill", "11h30 / 1 pill" ]
    let times = ["Before Meal","After Meal","Before Meal", "After Meal", "After Meal","After Meal"]

    //outlets
    
    
    //actions
    
    
    
    
    //functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TVCell = tableView.dequeueReusableCell(withIdentifier: "PCell", for: indexPath)
        let cv = TVCell.contentView
        let MedImg = cv.viewWithTag(1) as! UIImageView
        let name = cv.viewWithTag(2) as! UILabel
        let category = cv.viewWithTag(3) as! UILabel
        let time = cv.viewWithTag(4) as! UILabel
        let BorA = cv.viewWithTag(5) as! UILabel

        
        MedImg.image = UIImage(named: meds[indexPath.row])
        name.text = meds[indexPath.row]
        category.text = categories[indexPath.row]
        time.text = frequencies[indexPath.row]
        BorA.text = times[indexPath.row]

        return TVCell
    }
    


}
