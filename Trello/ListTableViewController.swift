//
//  TableViewController.swift
//  Trello
//
//  Created by Events on 11/13/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // MARK: Properties
    
    var boards = [Board]()
    var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load in sample data
        loadSampleData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }
    
    
    
    func loadSampleData() {
        var board1 = Board.init(name: "board1", description: "testing 1", id: "123wt3w342")
        var board2 = Board.init(name: "board2", description: "Testing 2", id: "1243aedfqaw435")
        
        
        var list = List.init(name: "List1", id: "1234qwraw345")
        
        for i in 1...4 {
            var card = Card.init(name: ("Card" + String(i)), description: "Testing description", id: "156408680sfd" + String(i), list_id: list.id)
            list.cards.append(card)
        }
        for i in 1...15 {
            lists += [list]
        }

        
        board1.lists.append(list)
        
        boards += [board1, board2]
        
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ListTableViewCell"
        
        let list = lists[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListTableViewCell

        cell.nameLabel.text = list.name
        
        return cell
    }

    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
