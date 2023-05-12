//
//  CategoryView.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI
import CoreLocation

struct CategoryView: View {
    
    @Environment(\.openURL) var openURL
    
    var facilities: [Facility]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(facilities, id: \.id) { facility in
                        Button {
                            openLocation(location: facility.location)
                        } label: {
                            FacilityRowView(facility: facility)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Объекты")
            .navigationBarTitleDisplayMode(.automatic)
    }
    
    func openLocation(location: CLLocation) {
        
        let link = "\(AppConst.link2GisPrefix)rsType/car/to/\(location.coordinate.longitude),\(location.coordinate.latitude)"
        if let linkUrl = URL(string: link) {
            if UIApplication.shared.canOpenURL(linkUrl) {
                openURL(linkUrl)
            } else {
                if let linkAppStoreUrl = URL(string: AppConst.linkAppStore) {
                    openURL(linkAppStoreUrl)
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoryView(facilities: [Facility(id: 1,
                                           name: "Wok Bar",
                                           description: "Попробовав любое блюдо из меню нашего ",
                                           imageUrl: "https://rsttur.ru/file/60c8769ba602f.jpeg",
                                           type: "food",
                                           location: CLLocation(latitude: 42.651126804049426,
                                                                longitude: 131.12555485413822)),
                                  Facility(id: 2,
                                           name: "Кальян",
                                           description: "Доставка кальянов по всей территории базы отдыха океан!",
                                           imageUrl: "https://rsttur.ru/file/1623240550j9trl.jpg",
                                           type: "fun",
                                           location: CLLocation(latitude: 42.651110964547378,
                                                                longitude: 131.12557899401938))])
        .preferredColorScheme(.light)
        CategoryView(facilities: [Facility(id: 1,
                                           name: "Wok Bar",
                                           description: "Попробовав любое блюдо из меню нашего ",
                                           imageUrl: "https://rsttur.ru/file/60c8769ba602f.jpeg",
                                           type: "food",
                                           location: CLLocation(latitude: 42.651126804049426,
                                                                longitude: 131.12555485413822)),
                                  Facility(id: 2,
                                           name: "Кальян",
                                           description: "Доставка кальянов по всей территории базы отдыха океан!",
                                           imageUrl: "https://rsttur.ru/file/1623240550j9trl.jpg",
                                           type: "fun",
                                           location: CLLocation(latitude: 42.651110964547378,
                                                                longitude: 131.12557899401938))])
        .preferredColorScheme(.dark)
    }
}
