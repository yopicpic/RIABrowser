RIABrowser
======

RIABrowser(Realm In App Browser) is Realm Object Viewer which is used in your swift application. 
RIABrowser is useful for debugging of your application which used Realm Databases.

![demo](https://github.com/yopicpic/RIABrowser-DemoMovie/raw/master/RIABrowserDemoMovie.gif)
## Requirements

- SWift 1.2
- iOS 8.0 and later
- Xcode 6.3 and later
- Realm Swift 0.93.0 and later

## Installation

CocoaPods is not supported yet.

- Installation of [Realm](https://realm.io/jp/docs/swift/latest/) into your project is required in advance.
  (RIABrowser support Dynamic Framework only)
- Clone this repository: `git clone git@github.com:yopicpic/RIABrowser.git`
- Copy `RIABrowser/` into your project.

## Usage

1.Register your model class of RealmSwift in AppDelegate.
```swift
import UIKit
import RealmSwift

//sample class
class User : Object {
  dynamic var id = NSUUID().UUIDString
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    RealmInAppBrowser.registerClass(User)

    return true
  }
```
Object of your model class that is not registered will not be displayed.


2. Add Launch Browser Button in any ViewController
```swift
override func viewDidLoad() {
  super.viewDidLoad()
  
  RealmInAppBrowser.sharedInstance.showLaunchButton(self)
}
```

## Sample
RIABrowser.xcodeproj is a sample project ,but RIABrowser.xcodeproj doesn't contain Realm.
If you want to invoke sample project, you need to install [Realm](https://realm.io/jp/docs/swift/latest/) into RIABrowser.xcodeproj.
(Support Dynamic Framework only)

## License

Copyright (c) 2015 Yoshiyuki Tanaka

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
