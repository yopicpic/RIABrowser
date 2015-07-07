//
//  RIAArrayProperty.swift
//  RealmInAppBrowserProto
//
//  Created by Yoshiyuki Tanaka on 2015/05/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation

class RIAArrayProperty : RIAProperty {
  
  init(type: String, name: String, arrayValue: Array<RIAObject>) {
    super.init(type: type, name: name, value: arrayValue as Array<RIAObject>)
  }
  
  
  override func value() -> NSArray {
    return super.value() as! NSArray
  }
}