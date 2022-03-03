//
//  CountryListViewController.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var lbSeconds: UILabel!
    //@IBOutlet weak var textfiedReponse: UITextField!
    
    @IBOutlet weak var textfield: UITextField!
    var continent = String()
    private let countriesAPICall = Service()
        
    var countries = [Country]()
    
    @IBAction func click(_ sender: Any) {
        var value = textfield.text!
        if(value == continent) {
            print("okok")
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
        }
    }
}

