//
//  ChallengeCardTableViewController.swift
//  bouldering
//
//  Created by 山脇寛之 on 2019/03/16.
//  Copyright © 2019 Hiroyuki. All rights reserved.
//

import UIKit


class ChallengeCardTableViewController: UITableViewController {
    
    var userDefaults = UserDefaults.standard
    var cards = [ChallengeCard]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadCards()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeCardTableViewCell", for: indexPath) as! ChallengeCardTableViewCell

        let card = self.cards[indexPath.row]
        // Configure the cell...

        updateCell(cell: cell, card: card)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let card = self.cards[index]
        let cell = tableView.cellForRow(at: indexPath) as! ChallengeCardTableViewCell
        
        let alertController = UIAlertController(title: card.difficulty + card.detail, message: "", preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "close", style: .cancel, handler: nil)
        let challengeAction = UIAlertAction(title: "Challenge", style: .default, handler: {
            (action: UIAlertAction!) in
            card.setChalengeDate()
            card.changeStatus(newStatus: .Challenging)
            
            self.updateCell(cell: cell, card: card)
            self.saveCards()
        })
        let completeAction = UIAlertAction(title: "Complete!", style: .default, handler: {
            (action: UIAlertAction!) in
            card.setComplateDate()
            card.changeStatus(newStatus: .Complete)
            
            self.updateCell(cell: cell, card: card)
            self.saveCards()
        })
        
        alertController.addAction(closeAction)
        switch card.status {
        case .UnChallenged:
            alertController.addAction(challengeAction)
        case .Challenging:
            alertController.addAction(completeAction)
        default:
            break
        }
        
        present(alertController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func loadCards() {
        let cards: [ChallengeCard]
        let encodeData = self.userDefaults.data(forKey: "cards")
        if (encodeData == nil) {
            NSLog("sample")
            // データがなかった時
            let count = 50
            for i in 1...count {
                let card = ChallengeCard(difficulty: "10級", detail: "No."+String(i), challengeDate: "", completeDate: "")
                self.cards.append(card)
            }
            self.saveCards()
            return
        }
        do {
            let data: Data = Data(encodeData!)
            cards = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [ChallengeCard]
            self.cards = cards
        } catch (let message){
            // TODO
            print(message)
            NSLog("hoge")
            // データがなかった時
            let count = 50
            for i in 1...count {
                let card = ChallengeCard(difficulty: "10級", detail: "No."+String(i), challengeDate: "", completeDate: "")
                self.cards.append(card)
            }
            self.saveCards()
        }
    }
    
    private func saveCards() {
        do {
            let encodeData: Data = try NSKeyedArchiver.archivedData(withRootObject: self.cards, requiringSecureCoding: false)
            self.userDefaults.set(encodeData, forKey: "cards")
            NSLog("saved")
        } catch (let message) {
            // TODO
            print(message)
            NSLog("save error")
        }
    }
    
    private func updateCell(cell: ChallengeCardTableViewCell, card: ChallengeCard) {
        cell.difficultyLabel.text = card.difficulty
        cell.detailLabel.text = card.detail
        cell.challengeDate.text = card.challengeDate
        cell.completeDate.text = card.completeDate
    }

}
