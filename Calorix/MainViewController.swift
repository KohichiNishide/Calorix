//
//  MainViewController.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/13.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ParseBridgeDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var foods = ["焼きそば", "出し巻き卵", "みそ汁", "ご飯（中）"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self;
        ModelLocator.sharedInstance.parseBridgeModel.delegate = self
        ModelLocator.sharedInstance.parseBridgeModel.asyncLoadAllFoods()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----------------UITableViewDelegate/UITableViewDataSource methods------------------//
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = foods[indexPath.row]
        cell.detailTextLabel?.text = "100kcal"
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    //----------------ParseBridgeDelegate methods------------------//
    
    func loadedAllFood(foods : NSArray) {
        NSLog("received foods %@", foods as NSArray)
    }
}
