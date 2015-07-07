//
//  ObjectExtractorTests.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/05/20.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation
import XCTest
import RealmSwift
import UIKit

class ObjectExtractorTests: XCTestCase {
  
  //MARK: Helpers
  let realmPathForTesting = "test.realm"
  var testUser:UserTest?
  
  func deleteRealmFilesAtPath(path: String) {
    let fileManager = NSFileManager.defaultManager()
    fileManager.removeItemAtPath(path, error: nil)
    let lockPath = path + ".lock"
    fileManager.removeItemAtPath(lockPath, error: nil)
  }
  
  func realmPath() -> String {
    var documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
    return documentsPath + "/test.reamlm"
  }
  
  func setupTestObject () {
    testUser = nil
    
    let user = UserTest()
    user.age = 1
    user.height = 2.3
    user.weight = 4.5
    let components = NSDateComponents()
    components.year = 2015
    components.month = 2
    components.day = 2
    components.hour = 4
    components.minute = 5
    components.second = 6
    let date = NSCalendar.currentCalendar().dateFromComponents(components)!
    user.birthDay = date
    user.profileImage = NSData(data: UIImagePNGRepresentation(UIImage(named: "sample_image")))
    user.favoriteMusic = NSData()
    
    let book1 = BookTest()
    book1.name = "book1"
    let book2 = BookTest()
    book2.name = "book2"
    let book3 = BookTest()
    book3.name = "book3"
    
    user.favoriteBook = book1
    user.books.removeAll()
    user.books.append(book2)
    user.books.append(book3)
    
    let realm = Realm()
    realm.write { () -> Void in
      realm.add(user)
    }
    testUser = user
  }
  
  func firstUserObjectRIAProperty (propertyName:String) -> RIAProperty? {
    let resultObjects = ObjectExtractor.sharedInstance.objects("UserTest")
    let resultProperties = resultObjects[0].properties
    for  property in resultProperties {
      if property.name == propertyName {
        return property
      }
    }
    return nil
  }
  
  override func setUp() {
    super.setUp()
    deleteRealmFilesAtPath(realmPath())
    Realm.defaultPath = realmPath()
    
    setupTestObject()
  }
  
  override func tearDown() {
    super.tearDown()
    deleteRealmFilesAtPath(realmPath())
    
    let realm = Realm()
    realm.write { () -> Void in
      realm.deleteAll()
    }
    
    ObjectExtractor.sharedInstance.unregisterClass(UserTest)
    ObjectExtractor.sharedInstance.unregisterClass(BookTest)
  }
  
  func testAddClass() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    let result = ObjectExtractor.sharedInstance.classNames[0]
    XCTAssertEqual(result, "UserTest", "should equal class name")
  }
  
  func testRemoveClass() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    ObjectExtractor.sharedInstance.unregisterClass(UserTest)
    
    XCTAssertEqual(ObjectExtractor.sharedInstance.classNames.count, 0, "should remove class")
  }
  
  func testStringProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)

    var result = ""
    if let stringProperty = firstUserObjectRIAProperty("id") as? RIAStringProperty {
      result = stringProperty.value() as String
    }
    let expect = testUser!.id
    
    XCTAssertEqual(result, expect, "should return same string value")
  }
  
  func testIntProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result = ""
    if let stringProperty = firstUserObjectRIAProperty("age") as? RIAStringProperty {
      result = stringProperty.value() as! String
    }
    let expect = testUser!.age.description
    
    XCTAssertEqual(result, expect, "should convert Int into String")
  }
  
  func testFloatProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result = ""
    if let stringProperty = firstUserObjectRIAProperty("height") as? RIAStringProperty {
      result = stringProperty.value() as! String
    }
    let expect = testUser!.height.description
    
    XCTAssertEqual(result, expect, "should convert Float into String")
  }
  
  func testDoubleProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result = ""
    if let stringProperty = firstUserObjectRIAProperty("weight") as? RIAStringProperty {
      result = stringProperty.value() as! String
    }
    let expect = testUser!.weight.description
    
    XCTAssertEqual(result, expect, "should convert Double into String")
  }

  func testDateProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result = ""
    if let dateProperty = firstUserObjectRIAProperty("birthDay") as? RIAStringProperty {
      result = dateProperty.value() as! String
    }
    let expect = testUser!.birthDay.description
    
    XCTAssertEqual(result, expect, "should convert NSDate into String")
  }
  
  func testImageDataProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result:UIImage? = nil
    if let dataProperty = firstUserObjectRIAProperty("profileImage") as? RIADataProperty {
      result = UIImage(data: dataProperty.value())
    }

    XCTAssertNotNil(result, "should convert NSData into UIImage")
  }
  
  func testDataProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result:NSData? = nil
    if let dataProperty = firstUserObjectRIAProperty("favoriteMusic") as? RIADataProperty {
      result = dataProperty.value()
    }
    
    XCTAssertNotNil(result, "should return NSData")
  }



  func testBoolProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    
    var result = ""
    if let boolProperty = firstUserObjectRIAProperty("hasCar") as? RIAStringProperty {
      result = boolProperty.value() as! String
    }
    let expect = testUser!.hasCar.description
    
    XCTAssertEqual(result, expect, "should convert Bool into String")
  }
  
  func testObjectProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    ObjectExtractor.sharedInstance.registerClass(BookTest)
    
    var result = ""
    if let objectProperty = firstUserObjectRIAProperty("favoriteBook") as? RIAObjectProperty {
      let object = objectProperty.value()
      for  property in object.properties {
        if property.name == "name" {
          let stringProperty = property as! RIAStringProperty
          result = stringProperty.value() as! String
          break
        }
      }
    }
    let expect = testUser!.favoriteBook.name

    XCTAssertEqual(result, expect, "should convert Bool into String")
  }

  func testArrayProperty() {
    ObjectExtractor.sharedInstance.registerClass(UserTest)
    ObjectExtractor.sharedInstance.registerClass(BookTest)
    
    var result = [String]()
    if let objectProperty = firstUserObjectRIAProperty("books") as? RIAArrayProperty {
      let objects = objectProperty.value()
      for  object in objects {
        for  property in object.properties {
          if property.name == "name" {
            let stringProperty = property as! RIAStringProperty
            result.append(stringProperty.value() as! String)
            break
          }
        }
      }
    }
    let expect1 = testUser!.books[0].name
    let expect2 = testUser!.books[1].name
    
    XCTAssertEqual(result[0], expect1, "should convert array element into RIAObject")
    XCTAssertEqual(result[1], expect2, "should convert array element into RIAObject")
  }



}
