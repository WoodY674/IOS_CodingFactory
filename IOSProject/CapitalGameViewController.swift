//
//  CountryListViewController.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit

class CapitaleGameViewController: UIViewController {
    
    
    @IBOutlet weak var lbSeconds: UILabel!
    //@IBOutlet weak var textfiedReponse: UITextField!
    @IBOutlet weak var btValider: UIButton!
    
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
            textfield.text = ""
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
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CapitaleGameViewController.counter), userInfo: nil, repeats: true )
        
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
            var dialogMessage = UIAlertController(title: "Information", message: "Partie terminée, score = \(score)", preferredStyle: .alert)
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

