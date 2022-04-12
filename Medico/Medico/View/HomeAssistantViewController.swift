//
//  HomeAssistantViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class HomeAssistantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   

    //var
    
    //var names = ["patient 1", "patient 2", "patient 3"]
    let names = ["patient 1", "patient 2", "patient 3"]
    
    var filteredNames = [String]()
    
    
    //outlets
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    //actions
    
    @IBAction func logoutBtn(_ sender: Any) {
    }
    
    @IBAction func DarkmodeBtn(_ sender: Any) {
    }
    //functions
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        filteredNames = names
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredNames.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let PLCell = tableView.dequeueReusableCell(withIdentifier: "PLCell")!
        
        let cv = PLCell.contentView
        let MedImg = cv.viewWithTag(1) as! UIImageView
        let name = cv.viewWithTag(2) as! UILabel
        
        MedImg.image = UIImage(named: filteredNames[indexPath.row])
        name.text = filteredNames[indexPath.row]
        
        return PLCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "patientList_patientDetails", sender: indexPath)
    }

    //searhBar config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNames = []
        if searchText == "" {
            filteredNames = names
        }else{
            for name in names {
                if name.lowercased().contains(searchText.lowercased()){
                    filteredNames.append(name)
                }
            }
        }
        tableView.reloadData()
    }
    

}


