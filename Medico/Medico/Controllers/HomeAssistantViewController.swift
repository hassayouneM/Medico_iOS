//
//  HomeAssistantViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class HomeAssistantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    

    //var
    
    var names = ["patient 1", "patient 2", "patient 3"]
    
    var isSearching = false
    var searchedPatient = [String]()
    
    
    //outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //actions
    
    
    //functions
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedPatient.count
        }else{
            return names.count
        }
           
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let PLCell = tableView.dequeueReusableCell(withIdentifier: "PLCell", for: indexPath)
        
        let cv = PLCell.contentView
        let MedImg = cv.viewWithTag(1) as! UIImageView
        let name = cv.viewWithTag(2) as! UILabel
        
        if isSearching {
            MedImg.image = UIImage(named: searchedPatient[indexPath.row])
            name.text = searchedPatient[indexPath.row]
        }else{
            MedImg.image = UIImage(named: names[indexPath.row])
            name.text = names[indexPath.row]
        }
        
        return PLCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "patientList_patientDetails", sender: indexPath)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPatient  = names.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}


