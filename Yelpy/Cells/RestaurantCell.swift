//
//  RestaurantCell.swift
//  Yelpy
//
//  Created by Joseph Fontana on 9/29/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var restuarantImage: UIImageView!
    
    @IBOutlet weak var categories: UILabel!
    
    @IBOutlet weak var rating: UIImageView!
    
    @IBOutlet weak var contact: UILabel!
    
    @IBOutlet weak var numberOfReviews: UILabel!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    var r: Restaurant! {
        
        didSet {
            
            label.text = r.name
            categories.text = r.mainCategory
            contact.text = r.phone
            numberOfReviews.text = String(r.reviews) + " reviews"
            
            let stringRating = String(format: "%.1f", r.rating)
            rating.image = UIImage(named: stringRating)
            restuarantImage.af.setImage(withURL: r.imageURL!)
            restuarantImage.layer.cornerRadius = 10
            restuarantImage.clipsToBounds = true
            
            activityLabel.text = r.activity
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
