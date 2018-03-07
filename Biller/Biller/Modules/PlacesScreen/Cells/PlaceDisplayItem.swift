//
//  PlaceDisplayItem.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import UIKit

public struct PlaceDisplayItem {
    var id: String = ""
    var name: String = "Yet another bill"
    var note: String = ""
    var photo: UIImage?

    static public func placeToDisplayItem(_ place: PlaceModel) -> PlaceDisplayItem {
        var displayItem = PlaceDisplayItem()
        displayItem.id = place.id
        displayItem.name = place.name

        if let comment = place.comment {
            displayItem.note = comment.text
        }

        if let data = place.photo {
            displayItem.photo = UIImage(data: data as Data)
        }

        return displayItem
    }
}
