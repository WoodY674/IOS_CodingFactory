//
//  CountryListViewController.swift
//  IOSProject
//
//  Created by Matteo RUFFE on 03/03/2022.
//



/*
import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountryByName { [self] in
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getCountryByName(completed: @escaping () -> ()) {
        let url = URL(string: "https://restcountries.com/v3.1/all")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.countries = try JSONDecoder().decode([Country].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON error")
                }
            }
        }
        task.resume()
    }
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as!
        CustomViewCell
                
                let country = countries[indexPath.row]
                cell.countrynameLabel?.text = Country.name
                cell.countryFlag.downloaded(from: Country.flag)
                
                return cell
            }
            
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                performSegue(withIdentifier: "showCountryDetails", sender: self)
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let destination = segue.destination as? CountryDetailsViewController {
                    destination.country = countries[(tableView.indexPathForSelectedRow?.row)!]
                }
            }
        }
*/
