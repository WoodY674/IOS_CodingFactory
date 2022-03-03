//
//  HomeViewController.swift
//  IOSProject
//
//  Created by Antoine Haller on 03/03/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Foundation

class HomeViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    let myCurrentUser = Auth.auth().currentUser?.uid
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        print("logout pressed")
        let dialogMessage = UIAlertController(title: "Confirm", message: "Do you really want to log out ?", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) ->
             Void in do {
                 try Auth.auth().signOut()
                 print("logged out")
               } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
               }
          })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
         })
         
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
        return
    }
    

}
