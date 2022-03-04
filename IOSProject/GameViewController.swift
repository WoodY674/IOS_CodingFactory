//
//  CountryListViewController.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.row {
        case 0:
             cell = tableView.dequeueReusableCell(withIdentifier: "cellCapitale") as! CustomViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "cellMonnaie") as! CustomViewCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "cellPays") as! CustomViewCell
        }
        return cell
    }
}

