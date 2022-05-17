//
//  HomeAssistantViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class HomeAssistantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   

    //var
    
    var assistant : User?
    //let names = ["patient 1", "patient 2", "patient 3"]
    
    var filteredPatients : [User] = []
    private var patients : [User] = []
    
    //outlets
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    //actions
    
    @IBAction func logoutBtn(_ sender: Any) {
    }
    var i = 1
    @IBAction func DarkmodeBtn(_ sender: Any) {
        
    }
    //functions
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        
        initializePage()
        
        
        searchBar.delegate = self
        
    }
    func initializePage() {
        
        UserViewModel().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
            [self] success, result in self.assistant = result
            
        }
        fetchPatientList()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredPatients.count
        //return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let PLCell = tableView.dequeueReusableCell(withIdentifier: "PLCell")!
        
        let cv = PLCell.contentView
       // let MedImg = cv.viewWithTag(1) as! UIImageView
        let name = cv.viewWithTag(2) as! UILabel
        
        //MedImg.image = UIImage(named: filteredNames[indexPath.row])
        name.text = filteredPatients[indexPath.row].name
        return PLCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(filteredPatients[indexPath.row]._id, forKey: "patientId")
        print("----------------patientId")
        print(UserDefaults.standard.string(forKey: "patientId"))
        performSegue(withIdentifier: "patientList_patientDetails", sender: indexPath)
    }

    func fetchPatientList() {
        print("---------------------")
        print(UserDefaults.standard.string(forKey: "id")!)
        print("---------------------")

        
        UserViewModel.sharedInstance.getPatientslist(id: UserDefaults.standard.string(forKey: "id")!) {[self] success, patientList in
            if success{
                patients = patientList!
                filteredPatients=patients
                tableView.reloadData()
            }else{
                self.present(Alert.makeServerErrorAlert(), animated: true)
            }
        }
    }

    //searhBar config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPatients = []
        if searchText == "" {
            filteredPatients = patients
        }else{
            for patient in patients {
                if (patient.name)!.lowercased().contains(searchText.lowercased()){
                    filteredPatients.append(patient)
                }
            }
        }
        tableView.reloadData()
    }
    
}


