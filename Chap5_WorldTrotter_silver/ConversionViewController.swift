//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Joonwon Lee on 7/17/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    var fahrenheitValue: Double?
    var celsiusValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentHour = Int(dateFormatter.stringFromDate(NSDate())) ?? 0
        
        var bgColor: UIColor?
        if currentHour > 9 && currentHour < 20 {
            bgColor = UIColor.whiteColor()
        } else {
           bgColor = UIColor.darkGrayColor()
        }
        view.backgroundColor = bgColor
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func disissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
}

extension ConversionViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}
