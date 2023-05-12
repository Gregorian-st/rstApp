//
//  RstColor.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI

struct RstColor {
    
    var isGradient: Bool = false
    var color: Color = .clear
    var gradient = LinearGradient(colors: [], startPoint: .leading, endPoint: .trailing)
    
    init(colorName: String) {
        
        let gradientList = [Gradient(colors: [Color(hex: "#FF3459"), Color(hex: "#FFB9493C")]),
                            Gradient(colors: [Color(hex: "#5B3CDC"), Color(hex: "#FF0CA9B3")]),
                            Gradient(colors: [Color(hex: "#0CE6E2"), Color(hex: "#FF5B1220")]),
                            Gradient(colors: [Color(hex: "#3E1451"), Color(hex: "#FFA788F5")]),
                            Gradient(colors: [Color(hex: "#98D9E4"), Color(hex: "#FFEE32B9")]),
                            Gradient(colors: [Color(hex: "#0AAD75"), Color(hex: "#FF617D85")]),
                            Gradient(colors: [Color(hex: "#415E8D"), Color(hex: "#FFD160D8")]),
                            Gradient(colors: [Color(hex: "#5371D4"), Color(hex: "#FF55E7D2")]),
                            Gradient(colors: [Color(hex: "#5E56F0"), Color(hex: "#FF1D2FA0")]),
                            Gradient(colors: [Color(hex: "#E23817"), Color(hex: "#FFFC7411")]),
                            Gradient(colors: [Color(hex: "#7F485563"), Color(hex: "#7F29323C")]),
                            Gradient(colors: [Color(hex: "#7F457FCA"), Color(hex: "#7F5691C8")]),
                            Gradient(colors: [Color(hex: "#7FFE8C00"), Color(hex: "#7FF83600")]),
                            Gradient(colors: [Color(hex: "#AF5941"), Color(hex: "#FF7253A7")]),
                            Gradient(colors: [Color(hex: "#3875E4"), Color(hex: "#FFE124AA")]),
                            Gradient(colors: [Color(hex: "#558DEC"), Color(hex: "#FF2DB0D6")]),
                            Gradient(colors: [Color(hex: "#0718B6"), Color(hex: "#FF1E674A")]),
                            Gradient(colors: [Color(hex: "#7F1D976C"), Color(hex: "#7F93F9B9")]),
                            Gradient(colors: [Color(hex: "#7FF09819"), Color(hex: "#7FEDDE5D")]),
                            Gradient(colors: [Color(hex: "#7F314755"), Color(hex: "#7F26A0DA")])]
        let gList = [LinearGradient(gradient: gradientList[0], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[1], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[2], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[3], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[4], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[5], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[6], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[7], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[8], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[9], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[10], startPoint: .bottom, endPoint: .top),
                     LinearGradient(gradient: gradientList[11], startPoint: .bottom, endPoint: .top),
                     LinearGradient(gradient: gradientList[12], startPoint: .bottom, endPoint: .top),
                     LinearGradient(gradient: gradientList[13], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[14], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[15], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[16], startPoint: .topLeading, endPoint: .bottomTrailing),
                     LinearGradient(gradient: gradientList[17], startPoint: .bottom, endPoint: .top),
                     LinearGradient(gradient: gradientList[18], startPoint: .bottom, endPoint: .top),
                     LinearGradient(gradient: gradientList[19], startPoint: .bottom, endPoint: .top)]
        
        let colorSplit = colorName.lowercased().split(separator: "-")
        guard colorSplit.count > 1
        else {
            self.isGradient = false
            self.color = .clear
            self.gradient = LinearGradient(colors: [], startPoint: .leading, endPoint: .trailing)
            return
        }
        
        isGradient = String(colorSplit[0]) == "g"
        if isGradient {
            let listId = (Int(colorSplit[1]) ?? 0) - 1
            if gList.indices.contains(listId) {
                self.isGradient = true
                self.color = .clear
                self.gradient = gList[listId]
            } else {
                self.isGradient = true
                self.color = .clear
                self.gradient = LinearGradient(colors: [], startPoint: .leading, endPoint: .trailing)
            }
        } else {
            self.isGradient = false
            self.color = Color(colorName: colorName) ?? .white
            self.gradient = LinearGradient(colors: [], startPoint: .leading, endPoint: .trailing)
        }
    }
}
