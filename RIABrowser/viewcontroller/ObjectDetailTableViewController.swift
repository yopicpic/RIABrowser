//
//  ObjectDetailTableViewController.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/04/11.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit

class ObjectDetailTableViewController: UITableViewController {
    var object:RIAObject!
    var cellHeightArray = [CGFloat]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.title = object.name
        setupCellHeight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  // MARK: - Table view Delegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "RIABrowser", bundle: nil)

    if let property = object.properties[indexPath.section] as? RIAObjectProperty {
      let viewController = storyboard.instantiateViewControllerWithIdentifier("ObjectDetailTableViewController") as! ObjectDetailTableViewController
      viewController.object = property.value()
      navigationController?.pushViewController(viewController, animated: true)
    } else if let property = object.properties[indexPath.section] as? RIAArrayProperty {
      let viewController = storyboard.instantiateViewControllerWithIdentifier("ObjectsTableViewController") as! ObjectsTableViewController
      viewController.objects = property.value() as! [RIAObject]
      if viewController.objects.count > 0 {
        let object = viewController.objects[0]
        viewController.className = object.name
      }
      navigationController?.pushViewController(viewController, animated: true)
    } else if let property = object.properties[indexPath.section] as? RIAStringProperty {
      let viewController = storyboard.instantiateViewControllerWithIdentifier("TextViewController") as! TextViewController
      viewController.text = property.value() as String
      viewController.navigationItem.title = property.name
      navigationController?.pushViewController(viewController, animated: true)
    }
  }
  
  // MARK: - Table view data source  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let property = object.properties[section]
    return property.name + "(\(property.type))"
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return object.properties.count
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let property = object.properties[indexPath.section]
    if let stringProperty = property as? RIAStringProperty {
      let cell = tableView.dequeueReusableCellWithIdentifier("ObjectDetailStringCell", forIndexPath: indexPath) as! UITableViewCell
      cell.textLabel?.text = stringProperty.value() as String
      cell.accessoryType = .DisclosureIndicator
      return cell
    } else if let dataProperty = property as? RIADataProperty {
      if let image = UIImage(data: dataProperty.value()) {
        let cell = tableView.dequeueReusableCellWithIdentifier("ObjectDetailImageCell", forIndexPath: indexPath) as! ObjectDetailImageCell
        cell.mainImageView?.image = image
        cell.accessoryType = .None
        return cell
      } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("ObjectDetailStringCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(dataProperty.value().bytes) byte"
        cell.accessoryType = .None
        return cell
      }
    } else if let objectProperty = property as? RIAObjectProperty {
      let cell = tableView.dequeueReusableCellWithIdentifier("ObjectDetailObjectCell", forIndexPath: indexPath) as! UITableViewCell
      let object = objectProperty.value()
      cell.textLabel?.text = "instance"
      cell.accessoryType = .DisclosureIndicator
      return cell
    } else if let objectProperty = property as? RIAArrayProperty {
      let cell = tableView.dequeueReusableCellWithIdentifier("ObjectDetailArrayCell", forIndexPath: indexPath) as! UITableViewCell
      let object = objectProperty.value() as! [RIAObject]
      cell.textLabel?.text = "\(object.count) instances"
      cell.accessoryType = .DisclosureIndicator
      return cell
    }
    return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
  }

  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellHeightArray[indexPath.section]
  }

  // MARK: - private method
  
  func setupCellHeight () {
    cellHeightArray = [CGFloat]()
    
    for property in object.properties {
      if property is RIADataProperty {
        cellHeightArray.append(80)
      } else {
        cellHeightArray.append(44)
      }
    }
  }
}
