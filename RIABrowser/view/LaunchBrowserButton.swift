//
//  LaunchBrowserButton.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/04/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit

class LaunchBrowserButton : UIButton {
  
  convenience init() {
    self.init(frame:CGRectZero)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  func setup() {
    let image = UIImage(named: "LaunchBrowser")!
    setImage(image, forState:.Normal)
    setTranslatesAutoresizingMaskIntoConstraints(false)
   
    addConstraints([
      NSLayoutConstraint(
        item: self,
        attribute: .Width,
        relatedBy: .Equal,
        toItem: nil,
        attribute: .Width,
        multiplier: 1.0,
        constant: image.size.width
      ),
      NSLayoutConstraint(
        item: self,
        attribute: .Height,
        relatedBy: .Equal,
        toItem: nil,
        attribute: .Height,
        multiplier: 1.0,
        constant: image.size.height
      )]
    )
    updateConstraints()
  }
}
