//
//  FacilityRowView.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI

struct FacilityRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var facility: Facility
    
    private let nameFontSize: CGFloat = 20
    private let descriptionFontSize: CGFloat = 15
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            WebImage(url: URL(string: facility.imageUrl))
                .resizable()
                .placeholder {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(width: 40, height: 30)
                }
                .scaledToFill()
                .frame(width: 90, height: 65)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                }
                .if(colorScheme == .light) { view in
                    view.shadow(radius: 5)
                }
            
            VStack(alignment: .leading) {
                Text("\(facility.name)")
                    .font(.system(size: nameFontSize, design: .rounded))
                    .foregroundColor(Color(.label))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
                
                Text("\(facility.description)")
                    .font(.system(size: descriptionFontSize, design: .default))
                    .foregroundColor(Color(.label))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 100)
    }
}

struct FacilityRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        FacilityRowView(facility: Facility(id: 1,
                                           name: "Wok Bar",
                                           description: "Попробовав любое блюдо из меню нашего ",
                                           imageUrl: "https://rsttur.ru/file/60c8769ba602f.jpeg",
                                           type: "food",
                                           location: CLLocation(latitude: 42.651126804049426,
                                                                longitude: 131.12555485413822)))
    }
}
