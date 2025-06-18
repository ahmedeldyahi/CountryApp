//
//  NetworkService.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(endpoint: APIEndpointContract) async throws -> T
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
}
