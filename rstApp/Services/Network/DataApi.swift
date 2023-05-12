//
//  DataApi.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 11.05.2023.
//

import Foundation

enum ApiError: Error {
    
    case requestFailed(description: String)
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case serviceError(description: String)
    
    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case let .serviceError(description): return "Service Error with Message: \(description)"
        }
    }
}

protocol DataApiProtocol {
    
    var session: URLSession { get }
    
    func fetchData(with request: URLRequest) async throws -> APIDataResult
}

extension DataApiProtocol {
    
    func fetchData(with request: URLRequest) async throws -> APIDataResult {
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse
        else {
            throw ApiError.requestFailed(description: "Invalid response")
        }
        guard httpResponse.statusCode == 200
        else {
            throw ApiError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }
        
        do {
            let result = try JSONDecoder().decode(APIDataResult.self, from: data)
            if result.success {
                return result
            } else {
                throw ApiError.serviceError(description: result.error ?? "Unknown Service Error")
            }
        } catch {
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}

final class NetworkSession: DataApiProtocol {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        
        self.init(configuration: .default)
    }
}
