//
//  ObjectsTableViewController.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/04/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit

class ObjectsTableViewController : UITableViewController {
  var className = ""
  var objects:[RIAObject] = []
  var selectedObject:RIAObject!
  
  override func viewDidLoad() {
    navigationItem.title = className + "(\(objects.count))"
  //  objects = RABModelAnalyzer.sharedInstance().objectsWithClassName(className) as! [RABObject]
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    if segue.identifier == "toObjectDetailTableViewController" {
      var objectDetailTableViewController = segue.destinationViewController as! ObjectDetailTableViewController
      objectDetailTableViewController.object = selectedObject
    }
  }
  
  //MARK:Private Method
  private func propertyValueToString(property:RIAProperty) -> String {
    if let stringProperty = property as? RIAStringProperty {
      return "\(stringProperty.name) = \(stringProperty.value())"
    } else if let dataProperty = property as? RIADataProperty {
      return "\(dataProperty.name) = \(dataProperty.value().bytes) byte"
    } else if let objectProperty = property as? RIAObjectProperty {
      let object = objectProperty.value()
      return "\(objectProperty.name) = \(object.name) instance"
    } else if let arrayProperty = property as? RIAArrayProperty {
      return "\(arrayProperty.name) = array data"
    }
    return ""
  }
    
  //MARK:UITableViewDelegate
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    selectedObject = objects[indexPath.row]
    return indexPath
  }
  
  //MARK:UITableViewDatasource
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }
  
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ObjectsTableViewCell") as! UITableViewCell
    
    let object = objects[indexPath.row]
    let properties:[RIAProperty] = object.properties
    var text:String? = nil
    
    for property:RIAProperty in properties {
      if text == nil {
        text = propertyValueToString(property)
      }
      if let primaryKey = object.primaryKey {
        if property.name == primaryKey {
          text = propertyValueToString(property)
          break
        }
      }
    }
    
    cell.textLabel?.text = "\(indexPath.row): " + text!
    return cell
  }
  
  //MARK: IBAction
  @IBAction func pressCloseButton(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

}
