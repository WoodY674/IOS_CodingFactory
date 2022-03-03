//
//  HomeViewController.swift
//  IOSProject
//
//  Created by Antoine Haller on 03/03/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {

    let date = Date()
    let dateFormatter = DateFormatter()
    
    private let database = Database.database().reference()
    
    let data: [String: String] = [
        "Player": "Antoine",
        "Game": "Monnaie",
        "Score": "25"
    ]
    let myCurrentUser = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var addEntryButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addEntryButton.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }
    
    @objc private func addNewEntry(){
            
            database.child(myCurrentUser!).setValue(data)
            //database.child(myCurrentUser!).child(dateFormatter.string(from: date)).setValue(data)
        
    }
    

}
