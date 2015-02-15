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
    
    var filterSettings : FilterSettings!
    var delegate : SettingsViewControllerDelegate?
    var filters : [Filter]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filters = Filter.defaultFilters()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        delegate?.didChangeFilters(filterSettings)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func setFilterSettings(filterSettings : FilterSettings) {
        self.filterSettings = filterSettings
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].displayName
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()

        var filter = filters[indexPath.section]
        
        cell.textLabel?.text = filter.values[indexPath.row].name
        
        if (filter.optionSelected(indexPath.row)) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters[section].values.count
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
    func didChangeFilters(filterSettings: FilterSettings)
}