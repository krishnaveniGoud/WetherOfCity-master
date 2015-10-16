//
//  DisplayVc.swift
//  WetherOfCity
//
//  Created by Administrator on 07/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit
import CoreLocation

class DisplayVc: UIViewController,CLLocationManagerDelegate,UITextFieldDelegate {

    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var citySearchTxt: UITextField!
    @IBOutlet var tolBar: UIToolbar!
    @IBOutlet var displayLbl: UILabel!
    @IBOutlet var wetherLabel: UILabel!
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.tolBar.backgroundColor = UIColor(red: 136.0/255, green: 155.0/255, blue: 218.0/255, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 136.0/255, green: 155.0/255, blue: 218.0/255, alpha: 1.0)
        self.citySearchTxt.delegate = self
        self.displayLbl.text = displayLbl.text! + (app.cityName as String) + ":"
        self.citySearchTxt.hidden = true
        self.searchBtn.hidden = true
        
    }
    override  func viewWillAppear(animated: Bool) {
        self.citySearchTxt.hidden = true
        self.searchBtn.hidden = true
        self.getReport()
        
    }
    func convertToCelsius(fahrenheit: Int) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
    func getReport(){
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(app.cityName as String, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error, terminator: "")
                let alert = UIAlertController(title: "Error", message: "PleaceCkeckYourNetWork", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler:self.handleCancel))
                self.presentViewController(alert, animated: true, completion: {
                    print("completion block")
                })

                
            }
            if let placemark: AnyObject = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!!.coordinate
                print("coordinates are \(coordinates.latitude)\(coordinates.longitude)", terminator: "")
               // let str1 = String (stringInterpolationSegment: coordinates.latitude)
               // let str2 = String (stringInterpolationSegment: coordinates.longitude)
                
                let apiKey = "aa5ab8ab3744b3fc320137c6efc17bb6"
                let  baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)")
                
                let dataObject = NSData(contentsOfURL: baseURL!)
                let weatherDictionary : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData( dataObject!, options: [])) as! NSDictionary
                let dir: AnyObject? = weatherDictionary.objectForKey("currently")
                print("dir \(dir)", terminator: "")
                let dig = dir!.valueForKey("temperature") as! Int
                print("dig \(dig)", terminator: "")
                let  temperature = self.convertToCelsius(dig)
                
                print("temperature \(temperature)", terminator: "")
                self.wetherLabel.text = String(temperature)
                
                
            }
        })

        
    }
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    @IBAction func backToHomePage(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Home") as! ViewController
        
        self.presentViewController(nextViewController, animated:true, completion:nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchUserWishLocation(sender: AnyObject) {
        app.cityName = self.citySearchTxt.text!
        self.getReport()
    }
    
    @IBAction func checkReport(sender: AnyObject) {
        self.citySearchTxt.hidden = false
        self.searchBtn.hidden = false
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key
    {
        textField.resignFirstResponder()
        return true;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
