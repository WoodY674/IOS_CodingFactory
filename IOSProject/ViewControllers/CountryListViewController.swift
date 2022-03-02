//
//  CountryListViewController.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [Country]()
    var filteredResult = [Country]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountriesData { [self] in
            self.tableView.reloadData()
        }
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getCountriesData(completed: @escaping () -> ()) {
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
        if searching {
            return filteredResult.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        let country = countries[indexPath.row]

        if searching {
            cell.countrynameLabel?.text = filteredResult[indexPath.row].name.official.capitalized
            cell.countryFlag.downloaded(from: filteredResult[indexPath.row].flags.png)

        } else {
            cell.countrynameLabel?.text = country.name.official.capitalized
            cell.countryFlag.downloaded(from: country.flags.png)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CountryDetails") as? CountryDetailsViewController {
            
            if searching {
                vc.country = filteredResult[indexPath.row]

            } else {
                vc.country = countries[indexPath.row]
            }
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CountryDetailsViewController {
            destination.country = countries[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
                filteredResult.removeAll()
                searching = false
            } else {
                filteredResult = countries.filter{ $0.name.official.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil }
                searching = true
            }
            tableView.reloadData()
    }
}
