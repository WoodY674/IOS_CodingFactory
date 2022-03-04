//
//  CountryListViewController.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Foundation

class FlagGameViewController: UIViewController {
    
    let myCurrentUser = Auth.auth().currentUser?.uid
    private let database = Database.database().reference()
    
    
    @IBOutlet weak var lbSeconds: UILabel!
    //@IBOutlet weak var textfiedReponse: UITextField!
    @IBOutlet weak var btValider: UIButton!
    
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var textfield: UITextField!
    var pays = String()
    var url = URL(string: "")
    private let countriesAPICall = Service()
        
    @IBOutlet weak var imgPays: UIImageView!
    var countries = [Country]()
    var score = 0
    
    
    @IBAction func click(_ sender: Any) {
        var value = textfield.text!
        if(value == pays) {
            counterScore()
            textfield.text = ""
            countriesAPICall.getCountriesRandomFlag(completion: {response, error in
                print(response)
                DispatchQueue.main.async {
                    let dataTask = URLSession.shared.dataTask(with: URL(string: String(response![0]))!) { [weak self] (data, _, _) in
                        if let data = data {
                            DispatchQueue.main.async {
                                // Create Image and Update Image View
                                self?.imgPays.image = UIImage(data: data)
                            }
                        }
                    }

                    // Start Data Task
                    dataTask.resume()
                    self.pays = String(response![1])
                }
            })
        }
    }
    var timer = Timer()
    
    var seconds = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CapitaleGameViewController.counter), userInfo: nil, repeats: true )
        
        countriesAPICall.getCountriesRandomFlag(completion: {response, error in
            print(response)
            DispatchQueue.main.async {
                let dataTask = URLSession.shared.dataTask(with: URL(string: String(response![0]))!) { [weak self] (data, _, _) in
                    if let data = data {
                        DispatchQueue.main.async {
                            // Create Image and Update Image View
                            self?.imgPays.image = UIImage(data: data)
                        }
                    }
                }

                // Start Data Task
                dataTask.resume()
                self.pays = String(response![1])
            }
        })
    }
    
    @objc func counter() {
        seconds-=1
        lbSeconds.text = String(seconds) + " seconds"
        
        if(seconds == 0) {
            timer.invalidate()
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fr_FR")
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let finalDate = dateFormatter.string(from: date)
            
            let data: [String: String] = [
                "Game": "Flags",
                "Score": String(score)
            ]
            
            //push it as child of the current user in DBs
            database.child(myCurrentUser!).child(finalDate).setValue(data)
            
            var dialogMessage = UIAlertController(title: "Information", message: "Game ended, score = \(score)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            textfield.isEnabled = false
            btValider.isEnabled = false
            
        }
    }
    
    func counterScore() {
        score+=1
        lbScore.text = String(score)
    }
}

