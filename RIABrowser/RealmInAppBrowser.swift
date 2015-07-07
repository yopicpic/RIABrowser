//
//  RealmInAppBrowser.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/04/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit
import RealmSwift

public enum Position {
  case LeftTop
  case LeftBottom
  case RightTop
  case RightBottom
}

public class RealmInAppBrowser : NSObject {
  private let topMargin:CGFloat = 10
  private let leftMargin:CGFloat = 10
  private let bottomMargin:CGFloat = -10
  private let rightMargin:CGFloat = -10

  private var targetViewController:UIViewController?
  private var launchButton =  LaunchBrowserButton()

  override init() {
    super.init()
    launchButton.addTarget(self, action: "pressLaunchButton:", forControlEvents: UIControlEvents.TouchUpInside)
  }
  
  
  //MARK: Public Method
  class var sharedInstance : RealmInAppBrowser {
    struct Static {
      static let instance : RealmInAppBrowser = RealmInAppBrowser()
    }
    return Static.instance
  }
  
  public class func registerClass<T:Object>(type:T.Type) {
    ObjectExtractor.sharedInstance.registerClass(T)
  }
  
  public class func unregisterClass<T:Object>(type:T.Type) {
    ObjectExtractor.sharedInstance.unregisterClass(T)
  }
  
  public func setup(realmPath: String) {
    ObjectExtractor.sharedInstance.realmPath = realmPath
  }
  
  public func showLaunchButton(toViewController: UIViewController) {
    showLaunchButton(toViewController, position: Position.RightBottom)
  }
  
  
  public func showLaunchButton(toViewController: UIViewController, position: Position) {
    launchButton.removeFromSuperview()
    targetViewController = nil
    
    toViewController.view.addSubview(launchButton)
    targetViewController = toViewController
    applyConstraints(position)
  }
  
  //MARK:Internal Method
  func pressLaunchButton(sender: UIButton) {
    let storyboard = UIStoryboard(name: "RIABrowser", bundle: nil)
    let viewController = storyboard.instantiateInitialViewController() as! UIViewController
    targetViewController?.presentViewController(viewController, animated: true, completion: nil)
  }
  
  //MARK:Private Method
  
  private func applyConstraints(position: Position) {
    let horizonalAttribute:NSLayoutAttribute;
    let horizonalMargin:CGFloat
    let verticalAttribute:NSLayoutAttribute;
    let verticalMargin:CGFloat
    
    switch position {
      case .LeftTop:
        horizonalAttribute = .Left
        verticalAttribute = .Top
        horizonalMargin = leftMargin
        verticalMargin = topMargin
      case .LeftBottom:
        horizonalAttribute = .Left
        verticalAttribute = .Bottom
        horizonalMargin = leftMargin
        verticalMargin = bottomMargin
      case .RightTop:
        horizonalAttribute = .Right
        verticalAttribute = .Top
        horizonalMargin = rightMargin
        verticalMargin = topMargin
      case .RightBottom:
        horizonalAttribute = .Right
        verticalAttribute = .Bottom
        horizonalMargin = rightMargin
        verticalMargin = bottomMargin
    }
    
    targetViewController?.view.addConstraints([
      NSLayoutConstraint(
        item: launchButton,
        attribute: horizonalAttribute,
        relatedBy: .Equal,
        toItem: targetViewController?.view,
        attribute: horizonalAttribute,
        multiplier: 1.0,
        constant: horizonalMargin
      ),
      NSLayoutConstraint(
        item: launchButton,
        attribute: verticalAttribute,
        relatedBy: .Equal,
        toItem: targetViewController?.view,
        attribute: verticalAttribute,
        multiplier: 1.0,
        constant: verticalMargin
      )]
    )
    
    targetViewController?.view.updateConstraints()
  }
  
  
}