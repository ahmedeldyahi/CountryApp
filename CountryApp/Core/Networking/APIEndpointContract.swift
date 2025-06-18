//
//  APIEndpointContract.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.

import Foundation
protocol APIEndpointContract {
    var method: HTTPMethod { get }
    var path: String { get }
    var urlRequest: URLRequest? { get }
    var queryItems: [URLQueryItem]? { get }
}


extension APIEndpointContract {
    var method: HTTPMethod { .GET }
    var scheme: String { "https" }
    var host: String { "restcountries.com" }
    var basePath: String { "/v3.1" }
}


enum HTTPMethod: String {
    case GET
    case POST
}
