//
//  NetworkService.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import SwiftUI

@MainActor
final class NetworkService: ObservableObject {
    
    private let session = NetworkSession()
    
    @Published private(set) var categories: [CategoryItem] = []
    @Published private(set) var facilities: [Facility] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    var request: URLRequest = {
        let url = URL(string: "https://rsttur.ru/api/base-app/map")!
        return URLRequest(url: url)
    }()
    
    func fetchData() async {
        do {
            let response = try await session.fetchData(with: request)
            categories = response.categories
            facilities = response.facilities
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
            hasError = true
        }
    }
}
