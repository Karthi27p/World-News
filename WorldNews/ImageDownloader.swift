//
//  ImageDownloader.swift
//  WorldNews
//
//  Created by karthi on 11/21/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit
var queue = OperationQueue()
var VCObject = ViewController()
var image = UIImage()
class ImageDownloader: Operation{
func downloadImage(urlContent: String, photoImageView: UIImageView)
 {
    queue.addOperation { () -> Void in
        
        let photoUrl = NSURL(string: urlContent)
        let data = NSData(contentsOf: photoUrl as! URL)
         image = UIImage(data: data as! Data)!
        OperationQueue.main.addOperation({
               photoImageView.image = image
        })
    }
 
 }

}
