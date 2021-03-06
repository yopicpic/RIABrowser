//
//  ObjectExtractor.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/05/10.
//  Copyright (c) 2015 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit
import RealmSwift

class ObjectExtractor {
  typealias Extractor = ()-> [RIAObject]
  typealias ArrayPropertyExtractor = (object:Object, name:String) -> [Object]?
  var realmPath = Realm.Configuration.defaultConfiguration.path!
  private var classes = [String:Extractor]()
  private var arrayPropertyExtractors = [String:ArrayPropertyExtractor]()
  
  class var sharedInstance : ObjectExtractor {
    struct Static {
      static let instance : ObjectExtractor = ObjectExtractor()
    }
    return Static.instance
  }
  
  func registerClass<T:Object>(type:T.Type) {
    let name = "\(type)".componentsSeparatedByString(".")[0]
    let extractor:Extractor = {
      var riaObjects = [RIAObject]()
      let realmSwiftObjects = self.realm.objects(type)
      for i in 0..<realmSwiftObjects.count {
        riaObjects.append(self.convertToRIAObject(realmSwiftObjects[i]))
      }
      return riaObjects
    }
    
    classes["\(name)"] = extractor
    
    let arrayPropertyExtractor:ArrayPropertyExtractor = {(object:Object, name:String) -> [Object]? in
      if let value = object.valueForKey(name) as? List<T> {
        var objectList = [Object]()
        for i in 0..<value.count {
          objectList.append(value[i])
        }
        return objectList
      }
      return nil
    }
    arrayPropertyExtractors["\(name)"] = arrayPropertyExtractor
  }
  
  func unregisterClass<T:Object>(type:T.Type) {
    let name = "\(type)".componentsSeparatedByString(".")[0]
    classes.removeValueForKey("\(name)")
    arrayPropertyExtractors.removeValueForKey("\(name)")
  }
  
  var classNames:[String] {
    get {
      var names = [String]()
      for (className, _) in classes {
        names.append(className)
      }
      
      return names;
    }
  }
  
  func objects (className: String) -> [RIAObject] {
    if let objects = classes[className]?() {
      return objects
    }
    return [RIAObject]()
  }
  
  private var realm:Realm {
    get {
      return try! Realm(path: realmPath)
    }
  }
  
  private func convertToRIAObject(object: Object) -> RIAObject {
    let riaObject = RIAObject(name: object.objectSchema.className)
    let primaryKeyProperty:Property? = object.objectSchema.primaryKeyProperty
    
    for property in object.objectSchema.properties {
      var isPrimaryKey = false
      if property == primaryKeyProperty {
        isPrimaryKey = true
      }
      let riaProperty =  convertToRIAProperty(object, name: property.name, type: property.type)
      riaObject.addProperty(riaProperty, primaryKey: isPrimaryKey)
    }
    return riaObject
  }
  
  private func convertToRIAProperty(object: Object, name: String,type :PropertyType) -> RIAProperty {
    switch type {
    case .String:
      return stringToString(object, name: name)
    case .Int:
      return intToString(object, name: name)
    case .Float:
      return floatToString(object, name: name)
    case .Double:
      return doubleToString(object, name: name)
    case .Bool:
      return boolToString(object, name: name)
    case .Date:
      return dateToString(object, name: name)
    case .Data:
      return dataToString(object, name: name)
    case .Object:
      return objectToString(object, name: name)
    case .Array:
      return arrayToString(object, name: name)
    case .Any:
      return anyToString(object, name: name)
    }
  }
  
  private func stringToString(object: Object, name: String) -> RIAStringProperty {
    let value = object.valueForKey(name) as! String
    return RIAStringProperty(type: "String", name: name, stringValue: value)
  }
  
  private func intToString(object: Object, name: String) -> RIAStringProperty {
    let value = object.valueForKey(name) as! Int
    return RIAStringProperty(type: "Int", name: name, stringValue: String(value))
  }
  
  private func floatToString(object: Object, name: String) -> RIAStringProperty {
    let value = object.valueForKey(name) as! Float
    return RIAStringProperty(type: "Float", name: name, stringValue: "\(value)")
  }
  
  private func doubleToString(object: Object, name: String) -> RIAStringProperty {
    let value = object.valueForKey(name) as! Double
    return RIAStringProperty(type: "Double", name: name, stringValue: "\(value)")
  }
  
  private func boolToString(object: Object, name: String) -> RIAStringProperty {
    let value = object.valueForKey(name) as! Bool
    return RIAStringProperty(type: "Double", name: name, stringValue: "\(value)")
  }
  
  private func dateToString(object: Object, name: String) -> RIAStringProperty {
    let value = object.valueForKey(name) as! NSDate
    return RIAStringProperty(type: "Date", name: name, stringValue: "\(value)")
  }
  
  private func dataToString(object: Object, name: String) -> RIAProperty {
    let value = object.valueForKey(name) as! NSData
    return RIADataProperty(type: "Data", name: name, dataValue: value)
  }

  private func objectToString(object: Object, name: String) -> RIAObjectProperty {
    let value = object.valueForKey(name) as! Object
    return RIAObjectProperty(type: "Object", name: name, objectValue:convertToRIAObject(value))
  }
  
  private func arrayToString(object: Object, name: String) -> RIAArrayProperty {
    var objects:[Object]?
    for (_, extractor) in arrayPropertyExtractors {
      objects = extractor(object: object, name: name)
      if objects != nil {
        break
      }
    }
    
    var riaObjects = objects?.map({ (o) -> RIAObject in
      return self.convertToRIAObject(o)
    })
    
    if riaObjects == nil {
      riaObjects = [RIAObject]()
    }
    return RIAArrayProperty(type: "Object", name: name, arrayValue:riaObjects!)
  }

  private func anyToString (object: Object, name: String) -> RIAStringProperty {
    return RIAStringProperty(type: "Any", name: name, stringValue: "Any type is not supported")
  }
}
