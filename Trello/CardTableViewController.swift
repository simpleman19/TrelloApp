// Chance Turner
//  CardTableViewController.swift
//  Trello
//
//  Created by Events on 11/13/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {

    var cards = [Card]()
    var list: List? = nil
    
    @IBOutlet var cardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func  unwindToCardList(sender: UIStoryboardSegue) {
        sleep(1)
        if let sourceViewController = sender.sourceViewController as? CardViewController{
            cards.append(sourceViewController.card!)
            cardTableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CardTableViewCell"
        
        let card = cards[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardTableViewCell
        
        cell.id = card.id
        cell.nameLabel.text = card.name
        cell.descLabel.text = card.description
        
        return cell
    }
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let card = cards[indexPath.row]
            TrelloAPI.sharedInstance.deleteTrelloCardById(card.id, onCompletion: { (json) in print("deleted") } )
            cards.removeAtIndex(indexPath.row)
            list!.cards.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cardDetailViewController = segue.destinationViewController as! CardViewController
        if segue.identifier == "ShowDetail" {
            // Get the cell that generated this segue.
            if let selectedCardCell = sender as? CardTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCardCell)!
                let selectedCard = cards[indexPath.row]
                cardDetailViewController.card = selectedCard
                cardDetailViewController.list = list
            }
            
        }
        cardDetailViewController.list = list
    }


}
