//
//  MainView.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 10.05.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var networkService = NetworkService()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 5) {
                    ForEach(networkService.categories) { category in
                        NavigationLink {
                            CategoryView(facilities: networkService.facilities.filter{ $0.type == category.type })
                        } label: {
                            CategoryRowView(category: category)
                        }
                    }
                }
                .padding(.horizontal)
                .task(priority: .medium) {
                    await networkService.fetchData()
                }
                .alert("", isPresented: $networkService.hasError) {} message: {
                    Text(networkService.errorMessage)
                }
            }
            .refreshable {
                Task {
                    await networkService.fetchData()
                }
            }
            .navigationTitle("Категории")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
        MainView()
            .preferredColorScheme(.dark)
    }
}
