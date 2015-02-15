//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, SettingsViewControllerDelegate {
    var client: YelpClient!
    var businesses: [Business] = []
    var filteredData: [Business] = []
    var searchBar: UISearchBar?
    var searchController: UISearchController!
    var filterSettings : FilterSettings!
    
    @IBOutlet weak var tableView: UITableView!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    var yelpClient : YelpClient!
    let defaultSearch = "thai"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterSettings = FilterSettings()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.allowsSelection = false
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        //navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = defaultSearch
        
        // Do any additional setup after loading the view, typically from a nib.
        self.yelpClient = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        doYelpSearch(defaultSearch)
    }
    
    func doYelpSearch(query: String) {
        NSLog("Doing search for %", query)
        yelpClient.searchWithTerm(query, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businesses = Business.businessesWithDictionaries(response.valueForKeyPath("businesses") as [NSDictionary])
            self.filteredData = self.businesses
            self.tableView.reloadData()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("business-cell") as BusinessCell
        cell.updateFromModel(filteredData[indexPath.row])
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        if searchText.isEmpty {
            doYelpSearch(defaultSearch)
        } else {
            doYelpSearch(searchText)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as SettingsViewController
        vc.delegate = self
        vc.setFilterSettings(filterSettings)
    }
    
    func didChangeFilters(filterSettings: FilterSettings) {
        self.filterSettings = filterSettings
        // do search
    }
    
}

