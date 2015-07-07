//
//  ViewController.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/05/16.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    var userDefaults = NSUserDefaults.standardUserDefaults()
    let didInitialize = userDefaults.boolForKey("didInitialize")
    if didInitialize == false {
      Realm().write { () -> Void in
        let user1 = User()
        user1.name = "user1"
        let book1 = Book()
        book1.name = "book1"
        user1.favoriteBook = book1
        user1.books.append(book1)
        Realm().add(user1, update: false)
        
        let user2 = User()
        user2.name = "user2"
        let book2 = Book()
        
        book2.name = "book2"
        user2.favoriteBook = book2
        user2.books.append(book2)
        Realm().add(user2, update: false)
      }
      
      userDefaults.setBool(true, forKey: "didInitialize")
      userDefaults.synchronize()
    }
    
    RealmInAppBrowser.sharedInstance.showLaunchButton(self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

