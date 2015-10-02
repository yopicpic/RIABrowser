//
//  ClassNamesTableViewController.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/04/04.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit

class ClassNamesTableViewController :UITableViewController {

  var classNames = [String]()
  var selectedClassNames = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    
    classNames = ObjectExtractor.sharedInstance.classNames
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    if segue.identifier == "toObjectsTableViewController" {
    let objectsViewController = segue.destinationViewController as! ObjectsTableViewController
      objectsViewController.className = selectedClassNames
      objectsViewController.objects = ObjectExtractor.sharedInstance.objects(selectedClassNames)
     // selectedClassNames = ""
    }
  }
  
  //MARK: IBAction
  @IBAction func pressCloseButton(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  //MARK:UITableViewDelegate  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    selectedClassNames = classNames[indexPath.row]
    return indexPath
  }

  //MARK:UITableViewDatasource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return classNames.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ClassNamesTableViewCell")!
    cell.textLabel?.text = classNames[indexPath.row]
    return cell
  }
}
