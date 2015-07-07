//
//  RIAObject.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/05/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation

class RIAObject : NSObject {
  let name:String
  private(set) var primaryKey:String?
  private(set) var properties = [RIAProperty]()
  
  init(name: String) {
    self.name = name

    super.init()
  }
  
  func addProperty(property: RIAProperty, primaryKey: Bool) {
    properties.append(property)

    if primaryKey == true {
      self.primaryKey = property.type
    }
  }
}