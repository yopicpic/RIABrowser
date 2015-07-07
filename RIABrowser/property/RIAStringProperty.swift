//
//  RIAStringProperty.swift
//  RealmInAppBrowserProto
//
//  Created by Yoshiyuki Tanaka on 2015/05/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation

class RIAStringProperty : RIAProperty {
  
  init(type: String, name: String, stringValue: String) {
    super.init(type: type, name: name, value: stringValue as NSString)
  }

  override func value() -> NSString {
    return super.value() as! NSString
  }
}