//
//  ViewController.swift
//  WetherOfCity
//
//  Created by Administrator on 07/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{
    @IBOutlet var tolBar: UITableView!

    @IBOutlet var cell: CityCell!
    @IBOutlet var tableView: UITableView!
    var nameArr = NSArray()
     let app = UIApplication.sharedApplication().delegate as! AppDelegate
       
    override func viewDidLoad() {
        super.viewDidLoad()
               nameArr = ["Hyderabad","Cennai","Bangalore","Mumbai","Delhi","Kolkata"]
        self.tolBar.backgroundColor = UIColor(red: 136.0/255, green: 155.0/255, blue: 218.0/255, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 136.0/255, green: 155.0/255, blue: 218.0/255, alpha: 1.0)
         self.tableView.backgroundColor = UIColor(red: 136.0/255, green: 155.0/255, blue: 218.0/255, alpha: 1.0)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return nameArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CityCell
        
            
            cell.cityName.text = nameArr [indexPath.row] as? String
        
        return cell
        
        
    }
    func convertString(string: String) -> String {
        let data = string.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        return NSString(data: data!, encoding: NSASCIIStringEncoding) as! String
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        
        app.cityName = (nameArr [indexPath.row] as? String)!
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Display") as! DisplayVc
        
        self.presentViewController(nextViewController, animated:true, completion:nil)

        
        
    }
       func tableView(tableView: UITableView, diddSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    
    
    
    
    


}

