//
//  User.swift
//
//  Created by Yoshiyuki Tanaka on 2015/05/16.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit
import RealmSwift

class UserTest : Object {
  dynamic var id = NSUUID().UUIDString
  dynamic var name = "Taro"
  dynamic var age = 18
  dynamic var height:Float = 172.4
  dynamic var weight:Double = 60.2
  dynamic var birthDay = NSDate()
  dynamic var profileImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "sample_image")))
  dynamic var favoriteMusic = NSData()
  dynamic var hasCar = true
  dynamic var favoriteBook = BookTest()
  let books = List<BookTest>()
  
  override static func primaryKey() -> String? {
    return "id"
  }
}

class BookTest : Object {
  dynamic var name = "book title"
}
