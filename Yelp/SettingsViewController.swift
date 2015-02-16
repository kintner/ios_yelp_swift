//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate : SettingsViewControllerDelegate?
    var filters : [Filter]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        NSLog("view didload")
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func filterTapped(sender: UIBarButtonItem) {
        delegate?.didChangeFilters(filters)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func setFilters(filters : [Filter]) {
        NSLog("setting filters: %@", filters)
        self.filters = filters
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].sectionName
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var filter = filters[indexPath.section]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if (filter.type == Filter.filterType.list) {
            cell.textLabel?.text = filter.values[indexPath.row].name
        
            if (filter.optionSelected(indexPath.row)) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        } else {
            cell.textLabel?.text = filter.values[0].name
            var switchControl = UISwitch()
            switchControl.addTarget(self, action: "switchToggled:", forControlEvents: UIControlEvents.ValueChanged)
            
            switchControl.on = filter.optionSelected(0)
            cell.accessoryView = switchControl
        }
        
        
        return cell
    }
    
    func switchToggled(sender: UISwitch) {
        var cell = sender.superview as UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        if let indexPath = tableView.indexPathForCell(cell) {
            var filter = filters[indexPath.section]
            sender.on = filter.toggleOption(0)
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var filter = filters[section]
        
        if filter.type == Filter.filterType.list {
            return filters[section].values.count
        } else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filters.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var filter = filters[indexPath.section]
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if filter.toggleOption(indexPath.row) {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.None)
    }
    
    

}

protocol SettingsViewControllerDelegate {
    func didChangeFilters(filters : [Filter])
}