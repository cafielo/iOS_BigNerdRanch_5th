//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Joonwon Lee on 7/31/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var firstSectionItems: [Item]?
    var secondSectionItems: [Item]?

    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        firstSectionItems = itemStore.allItems.filter { $0.valueInDollars > 50 }
        secondSectionItems = itemStore.allItems.filter { $0.valueInDollars <= 50 }
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return  firstSectionItems?.count ?? 0
        } else {
            let numberOfRows = secondSectionItems?.count ?? 0
            return numberOfRows + 1
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == secondSectionItems?.count {
            return 44
        } else {
            return 60
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard !(indexPath.section == 1 && indexPath.row == secondSectionItems?.count) else {
            let cell = tableView.dequeueReusableCellWithIdentifier("NoMoreCell", forIndexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        let item = indexPath.section == 0 ? firstSectionItems?[indexPath.row] : secondSectionItems?[indexPath.row]
        cell.textLabel?.text = item?.name ?? ""
        cell.detailTextLabel?.text = "$\(item?.valueInDollars ?? 0)"
        
        return cell
    }
}
