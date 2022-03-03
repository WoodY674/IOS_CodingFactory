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
    
    private let getCountriesFromApi = Service()

    var countries = [Country]()
    var filteredResult = [Country]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountriesFromApi.getCountries { [self] response, error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(response)
            }
        }
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
            cell.countrynameLabel?.text = filteredResult[indexPath.row].name.capitalized
            cell.countryFlag.downloaded(from: filteredResult[indexPath.row].flag)

        } else {
            cell.countrynameLabel?.text = country.name.capitalized
            cell.countryFlag.downloaded(from: country.flag)
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
            filteredResult = countries.filter{ $0.name.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil }
            searching = true
        }
        tableView.reloadData()
    }
}
