//
//  Parser.swift
//  WorldNews
//
//  Created by karthi on 11/15/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit

class Parser: NSObject {
    var news: [NewsFeedModel] = []
    var images: [String] = []
    let kTitle : String = "title"
    let kLocation : String = "location"
    let kPhoto : String = "photo"
    let kUpdate : String = "update_history"
    
    func generateNewsObjects(feedArray: [Dictionary<String, AnyObject>]) -> [NewsFeedModel]
    {
        for newsItem : Dictionary in feedArray
        {
            let newsObj = NewsFeedModel()
            newsObj.newsTitle = newsItem[kTitle] as! String?
            newsObj.newsLocation = newsItem[kLocation] as! String?
            newsObj.photoURL = newsItem[kPhoto] as! String?
            newsObj.newsUpdate = newsItem[kUpdate] as! String?
            news.append(newsObj)
            images.append(newsObj.photoURL!)
    
        
    }
        return news
   }
    func returnImagesCount() ->  [String]
    {
        return images
    }
}
