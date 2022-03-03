//
//  LoginViewController.swift
//  IOSProject
//
//  Created by Antoine Haller on 02/03/2022.
//

import UIKit
import Firebase
import SwiftUI

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Connect(_ sender: Any) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            guard authResult != nil, error == nil else {
                print("error")
                // Create new Alert
                let dialogMessage = UIAlertController(title: "Error", message: "Invalid email or password", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                self!.present(dialogMessage, animated: true, completion: nil)
                
                return
            }
            print("success")
            if Auth.auth().currentUser != nil {
              // User is signed in.
                print(Auth.auth().currentUser!)
            } else {
              // No user is signed in.
              // ...
            }
            //self?.performSegue(withIdentifier: "MainTabBarController", sender: (Any).self)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
