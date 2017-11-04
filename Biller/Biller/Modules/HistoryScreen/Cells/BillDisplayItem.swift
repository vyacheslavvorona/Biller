//
//  BillDisplayItem.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import UIKit

public struct BillDisplayItem {
    var name: String = "Yet another bill"
    var date: NSDate = NSDate()
    var note: String = ""
    var sum: Float = 0
    var photo: UIImage?
}
