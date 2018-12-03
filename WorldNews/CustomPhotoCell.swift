//
//  CustomPhotoCell.swift
//  WorldNews
//
//  Created by karthi on 11/17/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit

class CustomPhotoCell: UITableViewCell {
 
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var newsUpdate: UILabel!
   
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
       title.frame = CGRect(x: 10, y: 0, width: self.frame.width, height: 15)
        newsUpdate.frame = CGRect(x: 10, y: 10, width: 310, height: 60)
        location.frame = CGRect(x: 10, y: 70, width: self.frame.width, height: 15)
        photoImageView.frame = CGRect(x: 0, y: 80, width: 340, height: 300)
      
        
        
        
        
       // photoImageView.frame = CGRect(x: 0, y: 0, width: 500, height: 200)
      //  photoCell.frame = CGRect(x:0, y:0, width: 300, height: 300)
        
   
       
        
        //newsUpdate.textColor = UIColor.blue
       // photoImageView.frame = CGRect(x: 0, y: 30, width:240 , height: 188)
       // photoImageView.frame.origin = CGPoint(x: 0, y: 30)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
