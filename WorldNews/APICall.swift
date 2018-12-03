//
//  SessionCall.swift
//  WorldNews
//
//  Created by karthi on 11/15/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit
class APICall: NSObject {
    var modelObj = NewsFeedModel()
    var parserObj = Parser()
    func retriveData(completionHandler: @escaping ( _ status : Bool?, _ newsValue : [NewsFeedModel]?, _ imagesCount : [String]) -> ())
    {
        let requestURL = NSURL(string: "https://world-newshub.appspot.com/sample.json" )!
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest(url : requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (jsondata, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (jsondata != nil && statusCode == 200) {
                print(" file downloaded successfully.")
                do {
                   let newfeedDictionary = try JSONSerialization.jsonObject(with: jsondata!, options:
                        JSONSerialization.ReadingOptions.mutableContainers) as! [Dictionary<String, AnyObject>]
                    DispatchQueue.main.async {
                        let newsValue = self.parserObj.generateNewsObjects(feedArray: newfeedDictionary)
                        let imagesCount = self.parserObj.returnImagesCount()
                        completionHandler(true, newsValue, imagesCount)
                    }
                }
                catch
                {
                    print("JSON Processing Failed")
                    completionHandler(false, nil, [" "])
                }
            }
            else
            {
                completionHandler(false, nil, [" "])
            }
        }
            task.resume()
    }
    
}
