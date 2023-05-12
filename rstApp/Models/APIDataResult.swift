//
//  APIDataResult.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI
import CoreLocation

struct APIDataResult: Decodable {
    
    var success: Bool
    var error: String?
    var time: Date
    var location: CLLocation
    var categories: [CategoryItem] = []
    var facilities: [Facility] = []
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()
    
    enum MainCodingKeys: String, CodingKey {
        case success
        case error
        case time
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case geo
        case categories
        case objects
    }
    
    enum GeoCodingKeys: String, CodingKey {
        case lat
        case lon
    }
    
    enum CategoryCodingKeys: String, CodingKey {
        case name
        case type
        case icon
        case color
        case count
    }
    
    enum FacilityCodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image
        case type
        case close
        case icon
        case color
        case lat
        case lon
        case working_hours
    }
    
    enum ScheduleItemCodingKeys: String, CodingKey {
        case days
        case from
        case to
    }
    
    init(from decoder: Decoder) throws {
        
        let mainContainer = try decoder.container(keyedBy: MainCodingKeys.self)
        success = try mainContainer.decodeIfPresent(Bool.self, forKey: .success) ?? false
        error = try mainContainer.decodeIfPresent(String.self, forKey: .error)
        let timeString = try mainContainer.decodeIfPresent(String.self, forKey: .time) ?? ""
        time = dateFormatter.date(from: timeString) ?? Date.now
        
        let dataContainer = try mainContainer.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        
        let geoContainer = try dataContainer.nestedContainer(keyedBy: GeoCodingKeys.self, forKey: .geo)
        let locationLat = try geoContainer.decodeIfPresent(Float.self, forKey: .lat) ?? 0
        let locationLon = try geoContainer.decodeIfPresent(Float.self, forKey: .lon) ?? 0
        location = CLLocation(latitude: CLLocationDegrees(locationLat),
                              longitude: CLLocationDegrees(locationLon))
        
        var categoriesContainer = try dataContainer.nestedUnkeyedContainer(forKey: .categories)
        let categoriesCount = categoriesContainer.count ?? 0
        for index in 0..<categoriesCount {
            let categoryContainer = try categoriesContainer.nestedContainer(keyedBy: CategoryCodingKeys.self)
            categories.append(CategoryItem())
            categories[index].name = try categoryContainer.decodeIfPresent(String.self, forKey: .name) ?? ""
            categories[index].type = try categoryContainer.decodeIfPresent(String.self, forKey: .type) ?? ""
            categories[index].icon = try categoryContainer.decodeIfPresent(String.self, forKey: .icon) ?? ""
            let colorString = try categoryContainer.decodeIfPresent(String.self, forKey: .color) ?? ""
            categories[index].color = RstColor(colorName: colorString)
            categories[index].count = try categoryContainer.decodeIfPresent(UInt.self, forKey: .count) ?? 0
        }
        
        var facilitiesContainer = try dataContainer.nestedUnkeyedContainer(forKey: .objects)
        let facilitiesCount = facilitiesContainer.count ?? 0
        for index in 0..<facilitiesCount {
            let facilityContainer = try facilitiesContainer.nestedContainer(keyedBy: FacilityCodingKeys.self)
            facilities.append(Facility())
            facilities[index].id = try facilityContainer.decodeIfPresent(Int.self, forKey: .id) ?? 0
            facilities[index].name = try facilityContainer.decodeIfPresent(String.self, forKey: .name) ?? ""
            facilities[index].description = try facilityContainer.decodeIfPresent(String.self,
                                                                                  forKey: .description) ?? ""
            facilities[index].imageUrl = try facilityContainer.decodeIfPresent(String.self, forKey: .image) ?? ""
            facilities[index].type = try facilityContainer.decodeIfPresent(String.self, forKey: .type) ?? ""
            facilities[index].close = try facilityContainer.decodeIfPresent(Bool.self, forKey: .close) ?? false
            facilities[index].icon = try facilityContainer.decodeIfPresent(String.self, forKey: .icon) ?? ""
            let colorString = try facilityContainer.decodeIfPresent(String.self, forKey: .color) ?? ""
            facilities[index].color = RstColor(colorName: colorString)
            let locationLat = try facilityContainer.decodeIfPresent(Float.self, forKey: .lat) ?? 0
            let locationLon = try facilityContainer.decodeIfPresent(Float.self, forKey: .lon) ?? 0
            facilities[index].location = CLLocation(latitude: CLLocationDegrees(locationLat),
                                                    longitude: CLLocationDegrees(locationLon))

            do {
                var scheduleContainer = try facilityContainer.nestedUnkeyedContainer(forKey: .working_hours)
                let scheduleCount = scheduleContainer.count ?? 0
                for indexSchedule in 0..<scheduleCount {
                    let scheduleItemContainer = try scheduleContainer.nestedContainer(keyedBy: ScheduleItemCodingKeys.self)
                    facilities[index].schedule?.append(ScheduleItem())
                    var scheduleDayContainer = try scheduleItemContainer.nestedUnkeyedContainer(forKey: .days)
                    let dayCount = scheduleDayContainer.count ?? 0
                    for _ in 0..<dayCount{
                        if let dayNumber = try scheduleDayContainer.decodeIfPresent(UInt8.self) {
                            facilities[index].schedule?[indexSchedule].days.append(dayNumber)
                        }
                    }
                    facilities[index].schedule?[indexSchedule].timeFrom = try scheduleItemContainer.decodeIfPresent(String.self,
                                                                                                                    forKey: .from) ?? ""
                    facilities[index].schedule?[indexSchedule].timeTo = try scheduleItemContainer.decodeIfPresent(String.self,
                                                                                                                  forKey: .to) ?? ""
                }
            } catch {
                facilities[index].schedule = nil
            }
        }
    }
}
