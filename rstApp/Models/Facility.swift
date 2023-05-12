//
//  Facility.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 10.05.2023.
//

import SwiftUI
import CoreLocation

struct Facility {
    
    var id: Int = 0
    var name = String()
    var description = String()
    var imageUrl = String()
    var type = String()
    var close: Bool = false
    var icon = String()
    var color = RstColor(colorName: "")
    var location = CLLocation(latitude: 0, longitude: 0)
    var schedule: [ScheduleItem]?
}
