//
//  Color+Ext.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI

extension Color {
    
    /// Init with RGB of ARGB string
    /// - Parameter hex: RGB string (ex. #FFFFFF), or ARGB string (ex. #FFFFFFFF)
    init(hex: String) {
        
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    /// Init with Color Name
    /// - Parameter colorName: as per design specification (ex. "gray-01")
    init?(colorName: String) {
        
        func getColorCode(colorName: String) -> String? {
            
            let grayList = ["#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FAFAFA",
                            "#F5F5F5", "#E5E5E5", "#D9D9D9", "#D1D1D1", "#BFBFBF",
                            "#C7C7C7", "#A6A6A6", "#999999", "#808080", "#666666",
                            "#4D4D4D", "#333333", "#212121", "#0D0D0D", "#0D0D0D"]
            let primaryList = ["#F2F8FF", "#E6F1FE", "#CCE3FE", "#B3D5FD", "#99C7FD",
                               "#80B9FC", "#66ABFC", "#4096FB", "#2688FB", "#1A81FA"]
            let successList = ["#F3FBF7", "#E7F6F0", "#CFEDE1", "#B8E5D2", "#A0DCC3",
                               "#88D3B3", "#70CAA4", "#41B986", "#29B077", "#11A768"]
            let warningList = ["#FEF9F2", "#FDF3E6", "#FBE8CC", "#F9DCB3", "#F7D199",
                               "#F5C580", "#F3BA66", "#EFA333", "#ED971A", "#EB8C00"]
            let dangerList = ["#FFF5F5", "#FFECEB", "#FFD8D6", "#FFC5C2", "#FFB1AD",
                              "#FF9E99", "#FF8B85", "#FF645C", "#FF5047", "#FF3D33"]
            let infoList = ["#F2F9FC", "#E6F3FA", "#CCE8F5", "#B3DCF0", "#99D1EB",
                            "#80C5E5", "#66B9E0", "#33A2D6", "#1A97D1", "#008BCC"]
            let violetList = ["#F6F4FA", "#ECE9F5", "#DAD4EB", "#C7BEE0", "#B5A9D6",
                              "#A293CC", "#8F7DC2", "#6A52AD", "#583DA3", "#452799"]
            let purpleList = ["#F9F4FA", "#F3E9F5", "#E7D3EB", "#DCBEE0", "#D0A8D6",
                              "#C492CC", "#B87CC2", "#A151AD", "#953BA3", "#892599"]
            let yellowList = ["#FFFDF2", "#FFFCE6", "#FFF8CC", "#FFF5B3", "#FFF199",
                              "#FFEE80", "#FFEB66", "#FFE433", "#FFE01A", "#FFDD00"]
            let cyanList = ["#F2F9FA", "#E6F4F5", "#CCE9EB", "#B3DEE1", "#99D3D7",
                            "#80C8CD", "#66BDC3", "#33A7AF", "#1A9CA5", "#00919B"]
            
            let listSplit = colorName.lowercased().split(separator: "-")
            
            guard listSplit.count > 1
            else { return nil }
            
            let listName = String(listSplit[0])
            let listId = (Int(listSplit[1]) ?? 0) - 1
            
            switch listName {
            case "gray": return grayList.indices.contains(listId) ? grayList[listId] : nil
            case "primary": return primaryList.indices.contains(listId) ? primaryList[listId] : nil
            case "success": return successList.indices.contains(listId) ? successList[listId] : nil
            case "warning": return warningList.indices.contains(listId) ? warningList[listId] : nil
            case "danger": return dangerList.indices.contains(listId) ? dangerList[listId] : nil
            case "info": return infoList.indices.contains(listId) ? infoList[listId] : nil
            case "violet": return violetList.indices.contains(listId) ? violetList[listId] : nil
            case "purple": return purpleList.indices.contains(listId) ? purpleList[listId] : nil
            case "yellow": return yellowList.indices.contains(listId) ? yellowList[listId] : nil
            case "cyan": return cyanList.indices.contains(listId) ? cyanList[listId] : nil
            default: return nil
            }
        }
        
        if let colorCode = getColorCode(colorName: colorName) {
            self.init(hex: colorCode)
        } else {
            return nil
        }
    }
}
