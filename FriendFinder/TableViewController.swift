//
//  TableViewController.swift
//  FriendFinder
//
//  Created by Stephen Kaplan on 8/2/19.
//  Copyright © 2019 Michael Gecawicz. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct cellData {
    var opened = Bool()
    var title = String()
}

class TableViewController: UITableViewController {

    var tableViewData = [cellData]()
    var TableData:Array<String> = Array<String>() // Used for storing and reading JSON data
    var selectedCat = ""
    var selectedColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 45/255, alpha: 1.0)
        
        let ref = Database.database().reference()
        
        ref.child("Categories").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String : AnyObject]
            self.populate_Table(value!)
        }) { (error) in
            print(error.localizedDescription)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewData.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        cell.textLabel?.text = tableViewData[indexPath.section].title
        cell.textLabel?.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
        let c = Double(indexPath.section)*15.0;
        cell.backgroundColor = UIColor(red: CGFloat(c/255.0), green: 0/255, blue: 150/255, alpha: 1.0);
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            if tableViewData[indexPath.section].opened == true {
//                tableViewData[indexPath.section].opened = false
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            } else {
//                tableViewData[indexPath.section].opened = true
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            }
//        }
        
        self.selectedCat = tableViewData[indexPath.section].title
        
        let c = Double(indexPath.section)*15.0;
        selectedColor = UIColor(red: CGFloat(c/255.0), green: 0/255, blue: 150/255, alpha: 1.0);

        performSegue(withIdentifier: "cat", sender: self)
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cat"){
            let vc = segue.destination as! SubView
            vc.finalCat = self.selectedCat
            vc.mainColor = selectedColor
        }
    }
    
    
    
    func populate_Table(_ data: Dictionary<String, Any>) {
        let data = Array(data.keys).sorted()
        
        for cat in data {
            tableViewData.append(cellData(opened: false, title: cat))
        }

        DispatchQueue.main.async(execute: {self.do_table_refresh()})

    }
    
    
    func do_table_refresh() {
        self.tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
