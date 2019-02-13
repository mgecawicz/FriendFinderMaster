//
//  TopicView.swift
//  FriendFinder
//
//  Created by Stephen Kaplan on 12/2/19.
//  Copyright © 2019 Michael Gecawicz. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TopicView: UITableViewController {
    
    var finalCat = ""
    var finalSub = ""
    var mainColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    var tableViewData = [cellData]()
    var TableData:Array<String> = Array<String>() // Used for storing and reading JSON data
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Categories/"+finalCat+"/"+finalSub)
        
        ref.child("Categories/"+finalCat+"/"+finalSub).observeSingleEvent(of: .value, with: { (snapshot) in
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
    
    override func viewDidAppear(_ animated: Bool) {
        // Stuff
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
        //let c = Double(indexPath.section)*15.0;
        cell.backgroundColor = mainColor;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    var keyText = ""
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
        
        //        self.keyText = tableViewData[indexPath.section].title
        //        performSegue(withIdentifier: "key", sender: self)
    }
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        var vc = segue.destination as! DetailView
    //        vc.finalKey = self.keyText
    //    }
    
    
    
    func populate_Table(_ data: Dictionary<String, Any>) {
        let data = Array(data.keys).sorted()
        
        for cat in data {
            var subStuff = [String]()
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

