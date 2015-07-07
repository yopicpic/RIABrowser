//
//  RIADataProperty.swift
//  RealmInAppBrowserProto
//
//  Created by Yoshiyuki Tanaka on 2015/05/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation

class RIADataProperty : RIAProperty {
  
  init(type: String, name: String, dataValue: NSData) {
    super.init(type: type, name: name, value: dataValue)
  }
  
  override func value() -> NSData {
    return super.value() as! NSData
  }
}