//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var filterSettings : FilterSettings!
    var delegate : SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

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
    


}

protocol SettingsViewControllerDelegate {
    func didChangeFilters(filterSettings: FilterSettings)
}