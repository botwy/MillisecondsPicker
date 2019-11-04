//
//  TimePickerDelegate.swift
//  MillisecondsPicker
//
//  Created by Гончаров Денис Васильевич on 04.11.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

class MillisecondPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  
  enum PickerComponent: Int {
    case date, hour, minute, second, millisecond
  }
  
  let isDateShow: Bool
  
  init(isDateShow: Bool) {
    self.isDateShow = isDateShow
    super.init()
  }
  
  private lazy var pickerComponents: [PickerComponent] = {
    if self.isDateShow {
      return [.date, .hour, .minute, .second, .millisecond]
    }
    
    return [.hour, .minute, .second, .millisecond]
  }()
  
  func currentComponent(component: Int) -> PickerComponent {
    return pickerComponents[component]
  }
  
  func componentIndex(_ pickerComponent: PickerComponent) -> Int {
    return pickerComponents.firstIndex{ $0 == pickerComponent } ?? 0
  }
  
  let calendar = Calendar.current
  let firstDay: Date = DateComponents(calendar: Calendar.current, year: 1970, month: 1, day: 1).date!
  var day: Int = 1
  var month: Int = 1
  var year: Int = 1970
  var hour: Int = 0
  var minutes: Int = 0
  var seconds: Int = 0
  var milliseconds: Int = 0
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return pickerComponents.count
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch currentComponent(component: component) {
    case .date:
      return 365000
    case .hour:
      return 24
    case .minute,.second:
      return 60
    case .millisecond:
      return 1000
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let pickerComponent = currentComponent(component: component)
    
    if pickerComponent == .date, let selectDate = calendar.date(byAdding: .day, value: row, to: firstDay) {
      
      let formatter = DateFormatter()
      formatter.calendar = calendar
      formatter.dateStyle = .short
      
      return formatter.string(from: selectDate)
    }
    
    if pickerComponent == .millisecond {
      return String(format: "%03d", row)
    }
    
    return String(format: "%02d", row)
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let pickerComponent = currentComponent(component: component)
    switch pickerComponent {
    case .date:
      let date = calendar.date(byAdding: .day, value: row, to: firstDay)!
      let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
      day = dateComponents.day!
      month = dateComponents.month!
      year = dateComponents.year!
    case .hour:
      hour = row
    case .minute:
      minutes = row
    case .second:
      seconds = row
    case .millisecond:
      milliseconds = row
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    let pickerComponent = currentComponent(component: component)
    
    if pickerComponent == .date {
      return CGFloat(integerLiteral: 130)
    }
    
    if pickerComponent == .millisecond {
      return CGFloat(integerLiteral: 70)
    }
    
    return CGFloat(integerLiteral: 50)
  }
}
