//
//  CategoryItem.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 10.05.2023.
//

import SwiftUI

struct CategoryItem: Identifiable {
    
    var id = UUID()
    var name = String()
    var type = String()
    var icon = String()
    var color = RstColor(colorName: "")
    var count: UInt = 0
}
