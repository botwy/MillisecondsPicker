//
//  TimePickerView.swift
//  MillisecondsPicker
//
//  Created by Гончаров Денис Васильевич on 31.10.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class MillisecondPickerView: UIPickerView {
  
  private var pickerDelegate: MillisecondPickerDelegate!
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(frame: CGRect, initDate: Date, isDateShow: Bool = false) {
    self.init(frame: frame)
    pickerDelegate = MillisecondPickerDelegate(isDateShow: isDateShow)
    setup(initDate: initDate)
  }
  
  private func setup(initDate: Date) {
    let calendar = Calendar.current
    let dateTimeComponent = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: initDate)
    
    pickerDelegate.day = dateTimeComponent.day ?? 1
    pickerDelegate.month = dateTimeComponent.month ?? 1
    pickerDelegate.year = dateTimeComponent.year ?? 1970
    pickerDelegate.hour = dateTimeComponent.hour ?? 0
    pickerDelegate.minutes = dateTimeComponent.minute ?? 0
    
    delegate = pickerDelegate
    dataSource = pickerDelegate
    
    if let date = DateComponents(calendar: calendar, year: pickerDelegate.year, month: pickerDelegate.month, day: pickerDelegate.day).date {
      let timeZone = calendar.timeZone
      let numberDay: Int = (Int(date.timeIntervalSince1970) + timeZone.secondsFromGMT())/(60*60*24)
      selectRow(numberDay, inComponent: pickerDelegate.componentIndex(.date), animated: false)
    }
    
    selectRow(pickerDelegate.hour, inComponent: pickerDelegate.componentIndex(.hour), animated: false)
    selectRow(pickerDelegate.minutes, inComponent: pickerDelegate.componentIndex(.minute), animated: false)
  }
}
