//
//  Item.swift
//  git_profile
//
//  Created by Ibrahim Mohammed on 26/04/2025.
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
