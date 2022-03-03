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
        let player: String
        let game: String
        let score: String
    }
    
    var scoresList = [Scores]()
    
    let myCurrentUser = Auth.auth().currentUser?.uid
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        database.child(myCurrentUser!).observe(.value, with: {snapshot in
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                return
            }
            if let player = snapshotValue["Player"] as? String, let game = snapshotValue["Game"] as? String, let score = snapshotValue["Score"] as? String{
                    let newScore = Scores(player: player, game: game, score: score)
                self.scoresList.append(newScore)
                
                let indexPath = IndexPath(row: self.scoresList.count-1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
            print("Scores list : ",self.scoresList)
            print(snapshotValue)
            
            
        })
        if Auth.auth().currentUser != nil {
          // User is signed in.
            print(Auth.auth().currentUser!)
        } else {
          // No user is signed in.
          print("no user connected")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let scoreBygame = scoresList[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoresTableViewCell
        
        cell.playerLabel.text = scoreBygame.player
        cell.gameLabel.text = scoreBygame.game
        cell.scoreLabel.text = String(scoreBygame.score)
        
        return cell
    }
    


}
