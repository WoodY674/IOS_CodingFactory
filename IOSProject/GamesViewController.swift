//
//  GamesViewController.swift
//  IOSProject
//
//  Created by Antoine Haller on 03/03/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class GamesViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    let data: [String: String] = [
        "Player": "Antoine",
        "Game": "Monnaie",
        "Score": "25"
    ]
    let currentUser = Auth.auth().currentUser?.uid
    
    
    
    @IBOutlet weak var addEntryButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addEntryButton.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }
    
    @objc private func addNewEntry(){
        let key = currentUser! + data["Game"]!
        
        database.child(key).setValue(data)
    }
    


}
