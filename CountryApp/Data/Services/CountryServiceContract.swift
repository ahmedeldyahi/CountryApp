//
//  CountryServiceContract.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import Combine
// MARK: - Contract
protocol CountryServiceContract {
    func fetchCountry(by code: String) async throws -> Country?
    func searchCountries(by name: String) async throws -> [Country]
}

// MARK: - Implementation
final class CountryServiceImpl: CountryServiceContract {
    private let network: NetworkService

    init(network: NetworkService = NetworkManager()) {
        self.network = network
    }

    func fetchCountry(by code: String) async throws -> Country? {
        let endpoint = APIEndpoint.country(code: code)
        let result: CountryModel = try await network.fetch(endpoint: endpoint)
        return result.toCountry()
    }

    func searchCountries(by name: String) async throws -> [Country] {
        let endpoint = APIEndpoint.search(name: name)
        let result: [CountryModel] = try await network.fetch(endpoint: endpoint)
        return result.compactMap { $0.toCountry() }
    }
}
