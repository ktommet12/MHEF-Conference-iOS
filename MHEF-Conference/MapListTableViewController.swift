//
//  MapListTableViewController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 10/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class MapListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblMapListView: UITableView!
    
    var mapItems:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMapListView.dataSource = self
        tblMapListView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMapListView.dequeueReusableCell(withIdentifier: "mapListCell", for: indexPath) as! MapListTableCell
        
        cell.txtMapListItem.text = mapItems[indexPath.row]
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return mapItems.count
//    }
}
