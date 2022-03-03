//
//  RegisterViewController.swift
//  IOSProject
//
//  Created by Antoine Haller on 02/03/2022.
//

import UIKit
import Firebase
import SwiftUI


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    @IBAction func Connect(_ sender: Any) {
        
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        print(type(of: email))
        
        
        Auth.auth().createUser(withEmail: email!, password: password!) {
            authResult, error in
            guard authResult != nil, error == nil else {
                print("error")
                // Create new Alert
                 var dialogMessage = UIAlertController(title: "Error", message: "bad email or password", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
                
                return
            }
            
            //Registered success
            print("success")
        }
    }
}
