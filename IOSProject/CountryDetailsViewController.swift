//
//  CountryDetailsViewController.swift
//  IOSProject
//
//  Created by Matteo RUFFE on 03/03/2022.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbCapitale: UILabel!
    @IBOutlet weak var lbContinent: UILabel!
    private let countriesAPICall = Service()
    
    @IBOutlet weak var lbNom: UILabel!
    @IBOutlet weak var lbPopulation: UILabel!
    var country:Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        countriesAPICall.getCountryByName(countryName: "peru", completion: {response, error in
                    print(response)
                    DispatchQueue.main.async {
                        let dataTask = URLSession.shared.dataTask(with: URL(string: String(response![4]))!) { [weak self] (data, _, _) in
                                                if let data = data {
                                                    DispatchQueue.main.async {
                                                        // Create Image and Update Image View
                                                        self?.imageView.image = UIImage(data: data)
                                                    }
                                                }
                                            }

                                            // Start Data Task
                                            dataTask.resume()
                        self.lbContinent.text = String(response![2])
                        self.lbCapitale.text = String(response![1])
                        self.lbNom.text = String(response![0])
                        self.lbPopulation.text = String(response![3])
                    }
                })
    }
}
