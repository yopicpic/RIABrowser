//
//  RIAProperty.swift
//  RealmInAppBrowserProto
//
//  Created by Yoshiyuki Tanaka on 2015/05/03.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation

class RIAProperty : NSObject {
  let type:String
  let name:String
  private let _value:NSObject
  
  init(type:String, name:String, value:NSObject) {
    self.type = type
    self.name = name
    self._value = value

    super.init()
  }
  
  func value() -> NSObject {
    return _value
  }
}