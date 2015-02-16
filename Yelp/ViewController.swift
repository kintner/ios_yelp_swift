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
    var filters: [Filter] = []
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    var yelpClient : YelpClient!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filters = Filter.defaultFilters()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.allowsSelection = false
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "keywords"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar

        definesPresentationContext = true
        
        self.yelpClient = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        doYelpSearch()
        
        //performSegueWithIdentifier("filterPush", sender: nil)
    }
    
    func doYelpSearch() {
        let query = currentSearchText()
        
        NSLog("Doing search for %", query)
        SVProgressHUD.show()
        yelpClient.searchWithTerm(query, filters: filters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.businesses = Business.businessesWithDictionaries(response.valueForKeyPath("businesses") as [NSDictionary])
            self.filteredData = self.businesses
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Network Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
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
        doYelpSearch()
    }
    
    func currentSearchText() -> String {
        let searchText = searchController.searchBar.text
        return searchText.isEmpty ? "" : searchText
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as SettingsViewController
        vc.delegate = self
        vc.setFilters(filters)
    }
    
    func didChangeFilters(filters: [Filter]) {
        self.filters = filters
        doYelpSearch()
    }
    
}

