//
//  MockURLSession.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import Foundation
import XCTest
@testable import CountryApp

final class MockURLSession: URLSessionProtocol {
    var testData: Data?
    var testResponse: URLResponse?
    var testError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = testError {
            throw error
        }
        guard let data = testData, let response = testResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}

final class MockAPIEndpoint: APIEndpointContract {
    var queryItems: [URLQueryItem]?
    
    var badURL: Bool = false
    var path: String = ""
    
    init(badURL: Bool = false, path: String = "") {
        self.badURL = badURL
        self.path = path
    }
    var urlRequest: URLRequest? {
        if badURL {
            return nil
        }
        return URLRequest(url: URL(string: "https://api.example.com")!)
    }
}

final class MockNetworkMonitor: NetworkMonitorContract {
    var status: NetworkStatus = .connected
}


// MARK: - Mock NetworkService
final class MockNetworkService: NetworkService {
    var fetchResult: Any?
    var fetchError: Error?

    func fetch<T: Decodable>(endpoint: APIEndpointContract) async throws -> T {
        if let fetchError = fetchError {
            throw fetchError
        }
        guard let fetchResult = fetchResult as? T else {
            throw AppError.decodingFailed
        }
        return fetchResult
    }
}




struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
}
