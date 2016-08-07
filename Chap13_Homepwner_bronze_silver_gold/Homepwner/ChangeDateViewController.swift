//
//  ChangeDateViewController.swift
//  Homepwner
//
//  Created by Joonwon Lee on 8/7/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class ChangeDateViewController: UIViewController {
    
    var item: Item!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter: NSDateFormatter =  {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}
