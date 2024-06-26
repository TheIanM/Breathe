//
//  Item.swift
//  Breathe
//
//  Created by Ian M. on 2024-05-28.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
