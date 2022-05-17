//
//  ChoisirUtilisateurView.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 15/05/2022.
//

import UIKit

class ChoisirUtilisateurView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // VARS
    private var utilisateurs : [User] = []
    
    // WIDGETS
    @IBOutlet weak var tableView: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilisateurs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.contentView

        let imageProfile = contentView?.viewWithTag(1) as! UIImageView
        let labelName = contentView?.viewWithTag(2) as! UILabel
        let labelUsername = contentView?.viewWithTag(3) as! UILabel
        
        let utilisateur = utilisateurs[indexPath.row]
        
        let url = URL(string : HOST_POST_URL+"/uploads/"+utilisateur.photo!)
        imageProfile.loadImge(withUrl: url!)
        
        labelName.text = utilisateur.name!
    
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ChatViewModel.sharedInstance.creerNouvelleConversation(recepteur: utilisateurs[indexPath.row]._id!) { success, Conversation in
            if (success) {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.present(Alert.makeServerErrorAlert(), animated: true)
            }
        }
    }
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    // METHODS
    func initialize() {
        UserViewModel.sharedInstance.getPatientslist(id: UserDefaults.standard.string(forKey: "id")!) { success, utilisateursfromRep in
            if success {
                print("mesaaaaaaaaage")
                print(utilisateursfromRep)
                self.utilisateurs = utilisateursfromRep!
                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load utilisateurs "),animated: true)

            }
        }
    }
}

