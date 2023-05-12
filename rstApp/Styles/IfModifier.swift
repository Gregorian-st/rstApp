//
//  IfModifier.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI

extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
