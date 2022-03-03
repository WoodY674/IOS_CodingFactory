//
//  ScoresViewController.swift
//  IOSProject
//
//  Created by Antoine Haller on 03/03/2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ScoresViewController: UIViewController, UITableViewDataSource {
    
    private let database = Database.database().reference()

    @IBOutlet weak var tableView: UITableView!
    
    struct Scores {
        let game: String
        let score: String
    }
    
    var scoresList = [Scores]()
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let myCurrentUser = Auth.auth().currentUser?.uid

        tableView.dataSource = self
        
        if myCurrentUser != nil {
            database.child(myCurrentUser!).observe(.value, with: {snapshot in
                guard let snapshotValue = snapshot.value as? [String: Any] else {
                    return
                }
                
                if snapshot.exists() {
                        for child in snapshot.children {
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: Any]
                            let myScore = dict["Score"] as! String
                            let myGame = dict["Game"] as! String
                            let newScore = Scores(game: myGame, score: myScore)
                        self.scoresList.append(newScore)
                        
                        let indexPath = IndexPath(row: self.scoresList.count-1, section: 0)
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                        }
                }

                
            })
            
            
        } else {
            print("no user connected")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let scoreBygame = scoresList[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoresTableViewCell
        
        cell.gameLabel.text = scoreBygame.game
        cell.scoreLabel.text = String(scoreBygame.score)
        
        return cell
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        self.scoresList = []
    }
    


}
