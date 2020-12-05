//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreLocation

class RestaurantsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var restaurantsArray: [Restaurant] = []
    
    var filteredData: [Restaurant]! = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let locationManager = CLLocationManager()
    
    var latitude = 37.773972
    
    var longitude = -122.431297
    
    override func viewDidLoad() {
        
        print("Is this getting loaded?")
        
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
  
        tableView.dataSource = self
        searchBar.delegate = self
        
        //tableView.rowHeight = 160

        //getAPIData()

        //filteredData = restaurantsArray

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        latitude = locValue.latitude
        
        longitude = locValue.longitude
        
        getAPIData()
        
        self.tableView.reloadData() // reload data!
    }
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        
        print("Making the API request")
        
        API.getRestaurants(lat: latitude, long: longitude) { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            
            //print(restaurants)
            
            self.restaurantsArray = restaurants
            self.filteredData = self.restaurantsArray
            self.tableView.reloadData() // reload data!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        cell.label.text = restaurant["name"] as? String ?? ""
        
        let categories = restaurant["categories"] as! [[String:Any]]
        
        let cuisine = categories[0]["title"] as! String

        cell.categories.text = cuisine
        
        let number = restaurant["display_phone"] as! String
        
        cell.contact.text = number
        
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restuarantImage.af.setImage(withURL: imageUrl!)
        }
        
        let rating = restaurant["rating"] as! Double
        
        let stringRating = String(format: "%.1f", rating)
        print(stringRating)
        cell.rating.image = UIImage(named: stringRating)
        
        return cell
        */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = filteredData[indexPath.row]
        
        cell.r = restaurant
        
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filteredData = searchText.isEmpty ? restaurantsArray : restaurantsArray.filter { (item: Restaurant) -> Bool in
            
            let name = item.name
            print(name)
            return name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        }
        //print(filteredData)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier != "ProfileSegue"){
            let cell = sender as! UITableViewCell
            
            if let indexPath = tableView.indexPath(for: cell){
                let r = restaurantsArray[indexPath.row]
                let detailViewContoller = segue.destination as! RestaurantDetailViewController
                detailViewContoller.r = r
            }
        }
    }

}

/*
//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class RestaurantsViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    
    
    var restaurantsArray: [Restaurant] = []
    
    var filteredData: [Restaurant]! = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        tableView.dataSource = self
        searchBar.delegate = self
        
        //tableView.rowHeight = 160

        getAPIData()

        //filteredData = restaurantsArray

    }
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            
            //print(restaurants)
            
            self.restaurantsArray = restaurants
            self.filteredData = self.restaurantsArray
            self.tableView.reloadData() // reload data!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        cell.label.text = restaurant["name"] as? String ?? ""
        
        let categories = restaurant["categories"] as! [[String:Any]]
        
        let cuisine = categories[0]["title"] as! String

        cell.categories.text = cuisine
        
        let number = restaurant["display_phone"] as! String
        
        cell.contact.text = number
        
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restuarantImage.af.setImage(withURL: imageUrl!)
        }
        
        let rating = restaurant["rating"] as! Double
        
        let stringRating = String(format: "%.1f", rating)
        print(stringRating)
        cell.rating.image = UIImage(named: stringRating)
        
        return cell
        */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = filteredData[indexPath.row]
        
        cell.r = restaurant
        
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filteredData = searchText.isEmpty ? restaurantsArray : restaurantsArray.filter { (item: Restaurant) -> Bool in
            
            let name = item.name
            print(name)
            return name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        }
        //print(filteredData)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier != "ProfileSegue"){
            let cell = sender as! UITableViewCell
            
            if let indexPath = tableView.indexPath(for: cell){
                let r = restaurantsArray[indexPath.row]
                let detailViewContoller = segue.destination as! RestaurantDetailViewController
                detailViewContoller.r = r
            }
        }
    }

}

// ––––– TODO: Create tableView Extension and TableView Functionality

*/
