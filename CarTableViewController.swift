//
//  CarTableViewController.swift
//  test
//
//  Created by Bridges Penn on 11/16/16.
//  Copyright © 2016 Bridges Penn. All rights reserved.
//

import UIKit

class CarTableViewController: UITableViewController {
    
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem()
        
        if let savedCars = loadCars() {
            cars += savedCars
        }
        
        //loadSampleCars()
    }
    /*
    func loadSampleCars() {
        let car1 = Car()
        let car2 = Car()
        let car3 = Car()
        
        cars += [car1, car2, car3]
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CarTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CarTableViewCell
        
        let car = cars[indexPath.row]
        
        cell.makeLabel.text = car.Make + " " + car.Model
        //cell.modelLabel.text = car.Model
        cell.yearLabel.text = String(car.Year)
        cell.conditionLabel.text = String(car.Condition)
        
        return cell
    }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
     {
        // Return false if you do not want the specified item to be editable.
        return true
     }
 
    
    
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
     {
        if editingStyle == .Delete {
            cars.removeAtIndex(indexPath.row)
            saveCars()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
     }
    
    
    
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
     {
        let itemToMove:Car = cars[fromIndexPath.row]
        cars.removeAtIndex(fromIndexPath.row)
        cars.insert(itemToMove, atIndex: toIndexPath.row)
        
        saveCars()
     }
 
    
    
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
     {
        // Return false if you do not want the item to be re-orderable.
        return true
     }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if (segue.identifier == "ShowDetail") {
            let carDetailViewController = segue.destinationViewController as! ViewController
            
            if let selectedCarCell = sender as? CarTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCarCell)!
                let selectedCar = cars[indexPath.row]
                carDetailViewController.car = selectedCar
            }
        }
        
        else if (segue.identifier == "AddItem") {
            
        }
     }
 
    
    @IBAction func unwindToCarList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ViewController, car = sourceViewController.car {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                cars[selectedIndexPath.row] = car
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            
            else {
                let newIndexPath = NSIndexPath(forRow: cars.count, inSection: 0)
                cars.append(car)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            saveCars()
        }
    }
    
    // MARK: NSCoding
    func saveCars() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cars, toFile: Car.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save...")
        }
    }
    
    func loadCars() -> [Car]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Car.ArchiveURL.path!) as? [Car]
    }
}
