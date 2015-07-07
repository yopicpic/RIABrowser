//
//  RIAObjectProperty.swift
//  RealmInAppBrowserProto
//
//  Created by Yoshiyuki Tanaka on 2015/05/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import Foundation

class RIAObjectProperty : RIAProperty {
  
  init(type: String, name: String, objectValue: RIAObject) {
    super.init(type: type, name: name, value: objectValue)
  }
  
  override func value() -> RIAObject {
    return super.value() as! RIAObject
  }
}