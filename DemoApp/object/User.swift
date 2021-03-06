//
//  User.swift
//
//  Created by Yoshiyuki Tanaka on 2015/05/16.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit
import RealmSwift

class User : Object {
  dynamic var id = NSUUID().UUIDString
  dynamic var name = "Taro"
  dynamic var age = 18
  dynamic var height:Float = 172.4
  dynamic var weight:Double = 60.2
  dynamic var birthDay = NSDate()
  dynamic var profileImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "sample_image")!)!)
  dynamic var favoriteMusic = NSData()
  dynamic var hasCar = true
  dynamic var favoriteBook:Book? = Book()
  let books = List<Book>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
}

class Book : Object {
  dynamic var name = "book title"
}
