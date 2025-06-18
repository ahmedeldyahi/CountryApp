//
//  APIEndpoint.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import Foundation

enum APIEndpoint: APIEndpointContract {
    case countries(name: String)
    
    var path: String {
        switch self {
        case .countries(let name):
            return "/name/\(name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .countries:
            let fields = "name,capital,currencies,flags,cca3"
            return [URLQueryItem(name: "fields", value: fields)]
        }
        
    }
    
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + path
        components.queryItems = queryItems

        guard let url = components.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
