//
//  ViewController.swift
//  WorldNews
//
//  Created by karthi on 11/15/16.
//  Copyright © 2016 tringapps. All rights reserved.
//

import UIKit
var apBlue : UIColor = UIColor.init(red: 0.11, green: 0.57, blue: 1.00, alpha: 1.0)
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var baseScrollView: UIScrollView!

   
    
    let sessionObj = APICall()
    var newsFeeds : [NewsFeedModel]! = nil
    var newsStoredValues : [String] = []
    var newsStoredPhotos : [String] = []
    var refreshControl = UIRefreshControl()
    var path : String = ""
    var image : UIImage? = nil
    var queue = OperationQueue()
    var rowHeight = 380.0
    var imgDownloadObj = ImageDownloader()
    
    
    @IBOutlet weak var logo: UIBarButtonItem!
  
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionObj.retriveData( completionHandler: {(status: Bool?, newsValues, imagesCount) in
            if ((status == true) && (newsValues != nil))
            {
                self.newsFeeds = newsValues!
                self.newsStoredPhotos = imagesCount
                self.tableView.reloadData()
                           }
            
        })
        tableView.delegate = self
        tableView.dataSource = self
        baseScrollView.delegate = self
       //refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: UIControlEvents.valueChanged)
       //tableView.addSubview(refreshControl)
       //refreshControl.bounds = CGRect(x: 20, y: 0, width: 0, height: 0)
      
        self.baseScrollView.contentSize = CGSize(width: (self.view.frame.width), height: (self.baseScrollView.frame.height+100))
        self.baseScrollView.backgroundColor = apBlue
        baseScrollView.scrollsToTop = true
        self.tableView.backgroundColor = apBlue
    }
    func refresh()
    {
        refreshControl.endRefreshing()
    }
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
       baseScrollView.contentOffset = CGPoint(x: tableView.contentOffset.x , y: tableView.contentOffset.y / 0.2)
       print(tableView.contentOffset.y)
        print(baseScrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
            if (self.newsFeeds != nil) {
                return self.newsStoredPhotos.count
            }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let imageCell = tableView.dequeueReusableCell(withIdentifier: "photoCell")! as! CustomPhotoCell
            if (self.newsFeeds != nil)
            {
                let urlContent = self.newsFeeds[indexPath.row].photoURL
                imgDownloadObj.downloadImage(urlContent: urlContent!, photoImageView: imageCell.photoImageView)
                imageCell.title?.text = self.newsFeeds[indexPath.row].newsTitle
                imageCell.newsUpdate?.text = self.newsFeeds[indexPath.row].newsUpdate
                imageCell.location?.text = self.newsFeeds[indexPath.row].newsLocation
                tableView.allowsSelection = false
                
               
                
            
            }
           return(imageCell)
           
            }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
           return(CGFloat(rowHeight))
           }
    override func viewDidAppear(_ animated: Bool) {
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = apBlue
        navigationBar?.tintColor = UIColor.white
        
        let logoView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let logoImageView = UIImageView(image: UIImage(named: "Applogo"))
        logoImageView.frame = CGRect(x: -125, y: 0, width: logoView.frame.width, height: logoView.frame.height)
        logoView.addSubview(logoImageView)
        navigationItem.titleView = logoView
       
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let logoButton = UIButton()
        logoButton.frame = CGRect(x: 220, y: 0, width: 30, height: 30)
        logoButton.setImage(UIImage(named: "searchNew"), for: .normal)
        logoButton.addTarget(self, action: Selector(("searchButtonPressed")), for: .applicationReserved)
        searchView.addSubview(logoButton)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = searchView
        self.navigationItem.leftBarButtonItem = leftBarButton

        let menuButton = UIButton()
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.addTarget(self, action: Selector(("menuButtonPressed")), for: .applicationReserved)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = menuButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

