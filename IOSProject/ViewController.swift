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

class ViewController: UIViewController {
    
    let myCurrentUser = Auth.auth().currentUser?.uid
    private let database = Database.database().reference()
    

    @IBOutlet weak var lbSeconds: UILabel!
    //@IBOutlet weak var textfiedReponse: UITextField!
    
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var textfield: UITextField!
    var continent = String()
    private let countriesAPICall = Service()
        
    var countries = [Country]()
    var score = 0
    
    @IBAction func click(_ sender: Any) {
        var value = textfield.text!
        if(value == continent) {
            counterScore()
            countriesAPICall.getCountriesRandomCapital(completion: {response, error in
                print(response)
                DispatchQueue.main.async {
                    self.lbPays.text = String(response![0])
                    self.continent = String(response![1])
                }
            })
        }
    }
    @IBOutlet weak var lbPays: UILabel!
    var timer = Timer()
    
    var seconds = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true )
        
        countriesAPICall.getCountriesRandomCapital(completion: {response, error in
            print(response)
            DispatchQueue.main.async {
                self.lbPays.text = String(response![0])
                self.continent = String(response![1])
            }
        })
    }
    
    @objc func counter() {
        seconds-=1
        lbSeconds.text = String(seconds) + " secondes"
        if(seconds == 0) {
            timer.invalidate()
            
            // get current dateTime and convert it to string
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fr_FR")
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let finalDate = dateFormatter.string(from: date)
            
            let data: [String: String] = [
                "Game": "Capitale",
                "Score": String(score)
            ]
            
            //push it as child of the current user in DBs
            database.child(myCurrentUser!).child(finalDate).setValue(data)
        }
    }
    
    func counterScore() {
        score+=1
        lbScore.text = String(score)
    }
}

