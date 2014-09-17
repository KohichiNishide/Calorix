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
    var foods = [Food]()
    let kcalUnit = "kcal"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self;
        ModelLocator.sharedInstance.parseBridgeModel.delegate = self
        ModelLocator.sharedInstance.parseBridgeModel.asyncLoadAllMeals()
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
        cell.textLabel?.text = foods[indexPath.row].name
        cell.detailTextLabel?.text = String(foods[indexPath.row].calorie) + kcalUnit
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    //----------------ParseBridgeDelegate methods------------------//
    func loadedAllMeals() {
        // Executed by main thread
        ModelLocator.sharedInstance.parseBridgeModel.asyncLoadAllFoods()
    }
    
    func loadedAllFoods(foods : [Food]) {
        // Executed by main thread
        self.foods = foods
        self.tableView.reloadData()
    }
}
