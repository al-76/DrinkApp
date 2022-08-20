//
//  DrinksTableViewController.swift
//  DrinkApp
//
//  Created by Vyacheslav Konopkin on 20.08.2022.
//

import UIKit

class DrinksTableViewController: UITableViewController {
    let drinkData = ["Some wine", "Some beer", "Some stout", "Some porter"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinkData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        
        if let drinkCell = cell as? DrinksTableViewCell {
            drinkCell.drinkLabel.text = drinkData[indexPath.row]
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDrinkDetails",
              let destination = segue.destination as? DrinkDetailsHostingController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destination.rootView.drinkName = drinkData[indexPath.row]
    }
}
