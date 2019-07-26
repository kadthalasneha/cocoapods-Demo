//
//  ViewController.swift
//  CocoapodsDemo
//
//  Created by KADTHALA SNEHA on 27/02/19.
//  Copyright © 2019 KADTHALA SNEHA. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        withSwiftyJson()
       // withoutSwiftyJson()
        
       
    }
    func withSwiftyJson(){
        guard let url = URL(string: "https://api.myjson.com/bins/odim1")
            else{
                return
             }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let userJson = try JSON(data: dataResponse)
                if let name = userJson["name"].string {
                    print("name is :\(name)")
                }
                if let year  = userJson["birthday"]["year"].number,
                    let month = userJson["birthday"]["month"].number,
                    let day   = userJson["birthday"]["day"].number {
                    print("data od birth is: \(day)-\(month)-\(year)")
                  
                }
                if let isActive = userJson["isActive"].bool {
                    print("is active: \(isActive)")
                   
                }
                if let contactArr = userJson["contacts"].array {
                    for contactDict in contactArr {
                        if let type = contactDict["type"].string {
                            print(type)
                            // get type
                        }
                        if let value = contactDict["value"].string {
                            print(value)
                            
                        }
                    }
                }
            }
            catch{
                print(error)
            }
           
        
           
            
        }
        task.resume()
        
    }
    func withoutSwiftyJson(){
        guard let url = URL(string: "https://api.myjson.com/bins/odim1")
            else{
                return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            if let userDict = try? JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments) as? [String: Any] {
                if let name = userDict!["name"] as? String {
                    // get name
                    print("name is :\(name)")
                }
                if let birthdayDict = userDict!["birthday"] as? [String: Any] {
                     let year = birthdayDict["year"] as? Int
                    
                    
                     let month = birthdayDict["month"] as? Int
                    
                     let day = birthdayDict["day"] as? Int
                    print("data od birth is: \(day ?? 01)-\(month ?? 01)-\(year ?? 1997)")
                    
                   
                    // get birthday month and day
                }
                if let isActive = userDict!["isActive"] as? Bool {
                    // get isActive
                    print("is active: \(isActive)")
                    
                }
                if let contactArr = userDict!["contacts"] as? [[String: Any]] {
                    for contactDict in contactArr {
                        if let type = contactDict["type"] as? String {
                            // get contact type
                             print(type)
                        }
                        if let value = contactDict["value"] as? String {
                            // get contact type
                             print(value)
                        }
                    }
                }
            }
        }
        task.resume()
       
    }


}

