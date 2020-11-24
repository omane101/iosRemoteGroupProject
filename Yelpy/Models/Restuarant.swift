//
//  Restuarant.swift
//  Yelpy
//
//  Created by Joseph Fontana on 10/2/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation
import Parse

class Restaurant {
    
    var imageURL: URL?
    var url: URL?
    var name: String
    var mainCategory: String
    var phone: String
    var rating: Double
    var reviews: Int
    var id: String
    var latitude: Double
    var longitude: Double
    var activity: String
    
    init(dict:[String: Any]){
        imageURL = URL(string: dict["image_url"] as! String)
        name = dict["name"] as! String
        rating = dict["rating"] as! Double
        reviews = dict["review_count"] as! Int
        phone = dict["display_phone"] as! String
        url = URL(string: dict["url"] as! String)
        mainCategory = Restaurant.getMainCategory(dict: dict)
        id = dict["id"] as! String
        latitude = Restaurant.getCoordinates(dict: dict, position: 0)
        longitude = Restaurant.getCoordinates(dict: dict, position: 1)
        activity = Restaurant.getActivity(id: id)
    }
    
    static func getActivity(id: String) -> String {
        
        //print(id)
        var returnString = "Current Activity Level: Normal"
        
        let query = PFQuery(className: "locations")
        query.whereKey("businessID", equalTo: id)
        
        do {
            let results: [PFObject] = try query.findObjects()
            //print(results)
            let activityLevel = results[0].object(forKey: "currentRating") as! Int
            
            if (activityLevel != 0) {
                returnString = "Very Empty"
            }
        } catch {
            print(error)
        }
        
        /*
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)
                
                //Create the new location
                let parseObject = PFObject(className:"locations")

                parseObject["businessID"] = id

                // Saves the new object.
                parseObject.saveInBackground {
                  (success: Bool, error: Error?) in
                  if (success) {
                    // The object has been saved.
                    print("you were saved")
                    print(parseObject)
                    //returnString = "Current Activity Level: Normal"
                  } else {
                    // There was a problem, check error.description
                    print(error!.localizedDescription)
                  }
                }
                
            } else if let object = object {
                // The query succeeded with a matching result
                //print(object)
                //print("2")
                //print(object["currentRating"] as! Int)
                
                if (object["currentRating"] as! Int != 0){
                    returnString = "Current Activity Level: Very Empty"
                }
                else{
                    returnString = "Current Activity Level: Very Busy"
                }
                
            } else {
                // The query succeeded but no matching result was found
                print("you're not in the database yet")
                returnString = "Current Activity Level: Normal"
            }
        }
        */
        
        return returnString
     }
    
    static func getMainCategory(dict: [String:Any]) -> String {
        let categories = dict["categories"] as! [[String: Any]]
        return categories[0]["title"] as! String
    }
    
    static func getCoordinates(dict: [String:Any], position: Int) -> Double {
        let coordinates = dict["coordinates"] as! [String: Any]
        //print(coordinates["latitude"] as! Float)
        //print(coordinates["longitude"] as! Float)
        if (position == 0){
            return coordinates["latitude"] as! Double
        }
        else{
            return coordinates["longitude"] as! Double
        }

    }
    
    
}
