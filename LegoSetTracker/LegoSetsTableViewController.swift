//
//  LegoSetsTableViewController.swift
//  Lego List
//
//  Created by Luke Kollen on 8/27/18.
//  Copyright © 2018 Luke Kollen. All rights reserved.
//

import UIKit
import CoreData

class LegoSetsTableViewController: UITableViewController {
    
    var legoList = [LegoSet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = LegoSet.fetchRequest() as NSFetchRequest<LegoSet>
        let sortDescriptor = NSSortDescriptor(key: "setName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            legoList = try context.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        tableView.reloadData()
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return legoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "legoSetCellIdentifier", for: indexPath)
        let legoSet = legoList[indexPath.row]
        cell.textLabel?.text = legoSet.setName
        cell.detailTextLabel?.text = "Set Number: " + String(legoSet.setNumber) + " Piece Count: " + String(legoSet.pieceCount)
        
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if legoList.count > indexPath.row {
            let legoSet = legoList[indexPath.row]
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(legoSet)
            legoList.remove(at: indexPath.row)
            
            
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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

    
    // MARK: - Navigation

    
 

}
