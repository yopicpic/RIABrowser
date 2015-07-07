//
//  TextViewController.swift
//  RIABrowser
//
//  Created by Yoshiyuki Tanaka on 2015/06/01.
//  Copyright (c) 2015年 Yoshiyuki Tanaka. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  var text = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.text = text
  }
}


