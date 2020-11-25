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
    
    var imageURL: URL? //The image URL for the restaurant
    var url: URL? //The URL for the webpage
    var name: String //The name of the location
    var mainCategory: String //The cuisine type
    var phone: String //The phone number
    var rating: Double //The yelp rating
    var reviews: Int //The number of reviews
    var id: String //The unique yelp ID
    var latitude: Double //The latitude of the location
    var longitude: Double //The longitude of the location
    var activity: String //The activity rating of the location
    
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
    
    
    /*
     This function makes a GET request to our database to retrieve the current rating
     value. It will then assign a string to return based on the value that is stored.
     */
    static func getActivity(id: String) -> String {
        
        //print(id)
        
        var returnString = "Current Activity Level: Normal"
        
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: id)
        
        //Sync request
        do {
            let results: [PFObject] = try query.findObjects()
            //print(results)
            
            if results.isEmpty {
                returnString = "Current Activity Level: Normal"
                
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
            }
            else{
                let activityLevel = results[0].object(forKey: "currentRating")
            
            
                if (activityLevel as! Int != 0) {
                    returnString = "Current Activity Level: Very Empty"
                }
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
    
    //This function converts a pair of coordinates from an array of strings
    //to a double value based on the position provided. 0 = Latitude, 1 = Longitude
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
