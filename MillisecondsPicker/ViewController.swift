//
//  ViewController.swift
//  MillisecondsPicker
//
//  Created by Гончаров Денис Васильевич on 30.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let pickerViewFrame = CGRect(x: 10, y: 100, width: 400, height: 200)
    let timePicker = MillisecondPickerView(frame: pickerViewFrame, initDate: Date(), isDateShow: true)
    view.addSubview(timePicker)
  }
}

