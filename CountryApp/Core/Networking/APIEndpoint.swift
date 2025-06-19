//
//  APIEndpoint.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import Foundation

enum APIEndpoint: APIEndpointContract {
    case search(name: String)
    case country(code: String)
    
    
    var path: String {
        switch self {
        case .search(let name):
            return "/name/\(name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        case .country(code: let code):
            return "/alpha/\(code.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"

        }
    }
    
    var queryItems: [URLQueryItem]? {
        let fields = "name,capital,currencies,flags,cca3,region,subregion,population,area,timezones,latlng"
        return [URLQueryItem(name: "fields", value: fields)]
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
