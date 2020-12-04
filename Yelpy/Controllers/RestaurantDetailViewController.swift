//
//  RestaurantDetailViewController.swift
//  Yelpy
//
//  Created by Joseph Fontana on 10/2/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage
import Parse

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var businessId: UILabel!
    
    var r : Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantImage.af.setImage(withURL: r.imageURL!)
        
        restaurantName.text = r.name
        
        businessId.text = r.id
        
        print(r.latitude)
        print(r.longitude)
        
    
        let initialLocation = CLLocation(latitude: r.latitude, longitude: r.longitude)
        
        let placemarker = MKPointAnnotation()
        placemarker.title = r.name
        placemarker.coordinate = CLLocationCoordinate2D(latitude: r.latitude, longitude: r.longitude)
        map.addAnnotation(placemarker)
        
        centerMapOnLocation(initialLocation, mapView: map)

        
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    //Button logic
    //Basic implementation - user can vote as much as they want
    //1.)User clicks button
    //2.)Query the DB for the business ID
    //3.)Update the current rating to reflect the vote
    //4.)Alert to tell user vote was counted
    
    //Advanced implementation - user can vote once every 10 minutes
    //1.)User clicks button
    //2.)Query the DB for the user's last vote time
    //3.)If the last vote time was more than 10 minutes ago:
    //  a.)Update the current rating to reflect the vote
    //  b.)Alert to tell user vote was counted
    //4.)If the vote was too recent:
    //   a.)Alert to tell user vote was not counted
    
    
    //Basic idea behind voting system
    //A too busy vote pushes the rating towards the negative
    //A very empty vote pushes the rating towards the positive
    //A normal vote pushes towards the positive if it is negative, and vice versa or keeps it at 0 if it already is at 0.
    
    
    @IBAction func busyButton(_ sender: Any) {
        
        print("busy button")
        
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: r.id)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)

            } else if let object = object {

                var currentActivity = object["currentRating"] as! Int
                
                currentActivity -= 1
                
                object["currentRating"] = currentActivity
                
                object.saveInBackground()
                
                print("Success saving the vote")
                
            } else {
                // The query succeeded but no matching result was found
                print("Something weird happened")
    
            }
        }
        
        let alert = UIAlertController(title: "Thanks!", message: "We've counted your vote!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func normalButton(_ sender: Any) {
        
        print("normal button")
    
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: r.id)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)

            } else if let object = object {

                var currentActivity = object["currentRating"] as! Int
                
                if(currentActivity < 0){
                    currentActivity += 1
                }
                else if (currentActivity > 0){
                    currentActivity -= 1
                }
                else{
                    currentActivity = 0
                }
                
                object["currentRating"] = currentActivity
                
                object.saveInBackground()
                
                print("Success saving the vote")
                
            } else {
                // The query succeeded but no matching result was found
                print("Something weird happened")
    
            }
        }
    
        let alert = UIAlertController(title: "Thanks!", message: "We've counted your vote!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func emptyButton(_ sender: Any) {
        
        print("empty button")
        
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: r.id)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)

            } else if let object = object {

                var currentActivity = object["currentRating"] as! Int
                
                currentActivity += 1
                
                object["currentRating"] = currentActivity
                
                object.saveInBackground()
                
                print("Success saving the vote")
                
            } else {
                // The query succeeded but no matching result was found
                print("Something weird happened")
    
            }
        }
        
        let alert = UIAlertController(title: "Thanks!", message: "We've counted your vote!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*
//
//  RestaurantDetailViewController.swift
//  Yelpy
//
//  Created by Joseph Fontana on 10/2/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage
import Parse

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var businessId: UILabel!
    
    var r : Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantImage.af.setImage(withURL: r.imageURL!)
        
        restaurantName.text = r.name
        
        businessId.text = r.id
        
        print(r.latitude)
        print(r.longitude)
        
    
        let initialLocation = CLLocation(latitude: r.latitude, longitude: r.longitude)
        
        let placemarker = MKPointAnnotation()
        placemarker.title = r.name
        placemarker.coordinate = CLLocationCoordinate2D(latitude: r.latitude, longitude: r.longitude)
        map.addAnnotation(placemarker)
        
        centerMapOnLocation(initialLocation, mapView: map)

        
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    //Button logic
    //Basic implementation - user can vote as much as they want
    //1.)User clicks button
    //2.)Query the DB for the business ID
    //3.)Update the current rating to reflect the vote
    //4.)Alert to tell user vote was counted
    
    //Advanced implementation - user can vote once every 10 minutes
    //1.)User clicks button
    //2.)Query the DB for the user's last vote time
    //3.)If the last vote time was more than 10 minutes ago:
    //  a.)Update the current rating to reflect the vote
    //  b.)Alert to tell user vote was counted
    //4.)If the vote was too recent:
    //   a.)Alert to tell user vote was not counted
    
    
    //Basic idea behind voting system
    //A too busy vote pushes the rating towards the negative
    //A very empty vote pushes the rating towards the positive
    //A normal vote pushes towards the positive if it is negative, and vice versa or keeps it at 0 if it already is at 0.
    
    
    @IBAction func busyButton(_ sender: Any) {
        
        print("busy button")
        
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: r.id)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)

            } else if let object = object {

                var currentActivity = object["currentRating"] as! Int
                
                currentActivity -= 1
                
                object["currentRating"] = currentActivity
                
                object.saveInBackground()
                
                print("Success saving the vote")
                
            } else {
                // The query succeeded but no matching result was found
                print("Something weird happened")
    
            }
        }
        
        let alert = UIAlertController(title: "Thanks!", message: "We've counted your vote!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func normalButton(_ sender: Any) {
        
        print("normal button")
    
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: r.id)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)

            } else if let object = object {

                var currentActivity = object["currentRating"] as! Int
                
                if(currentActivity < 0){
                    currentActivity += 1
                }
                else if (currentActivity > 0){
                    currentActivity -= 1
                }
                else{
                    currentActivity = 0
                }
                
                object["currentRating"] = currentActivity
                
                object.saveInBackground()
                
                print("Success saving the vote")
                
            } else {
                // The query succeeded but no matching result was found
                print("Something weird happened")
    
            }
        }
    
        let alert = UIAlertController(title: "Thanks!", message: "We've counted your vote!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func emptyButton(_ sender: Any) {
        
        print("empty button")
        
        //Query the DB
        let query = PFQuery(className: "locations")
        
        //Find the specific location
        query.whereKey("businessID", equalTo: r.id)
        
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) in
            if let error = error {
                // The query failed
                print(error.localizedDescription)

            } else if let object = object {

                var currentActivity = object["currentRating"] as! Int
                
                currentActivity += 1
                
                object["currentRating"] = currentActivity
                
                object.saveInBackground()
                
                print("Success saving the vote")
                
            } else {
                // The query succeeded but no matching result was found
                print("Something weird happened")
    
            }
        }
        
        let alert = UIAlertController(title: "Thanks!", message: "We've counted your vote!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
*/
