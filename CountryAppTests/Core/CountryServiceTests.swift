//
//  CountryServiceTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import XCTest
@testable import CountryApp

final class CountryServiceTests: XCTestCase {
    private var mockNetwork: MockNetworkService!
    private var service: CountryServiceImpl!

    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkService()
        service = CountryServiceImpl(network: mockNetwork)
    }

    func testFetchCountry_shouldReturnSingleCountry() async throws {
        mockNetwork.fetchResult =
            CountryModel(
                name: .init(common: "Canada"),
                capital: ["Ottawa"],
                currencies: ["CAD": .init(name: "Canadian Dollar")],
                flags: .init(png: "https://flagcdn.com/ca.png"),
                cca3: "CAN",
                region: nil,
                subregion: nil,
                population: nil,
                area: nil,
                timezones: nil,
                latlng: nil
            )

        let result = try await service.fetchCountry(by: "CA")

        XCTAssertEqual(result?.name, "Canada")
        XCTAssertEqual(result?.capital, "Ottawa")
        XCTAssertEqual(result?.currency, "Canadian Dollar")
    }

    func testSearchCountries_shouldReturnList() async throws {
        mockNetwork.fetchResult = [
            CountryModel(
                name: .init(common: "France"),
                capital: ["Paris"],
                currencies: ["EUR": .init(name: "Euro")],
                flags: .init(png: "https://flagcdn.com/fr.png"),
                cca3: "FRA",
                region: nil,
                subregion: nil,
                population: nil,
                area: nil,
                timezones: nil,
                latlng: nil
            ),
            CountryModel(
                name: .init(common: "Germany"),
                capital: ["Berlin"],
                currencies: ["EUR": .init(name: "Euro")],
                flags: .init(png: "https://flagcdn.com/de.png"),
                cca3: "DEU",
                region: nil,
                subregion: nil,
                population: nil,
                area: nil,
                timezones: nil,
                latlng: nil
            )
        ]

        let result = try await service.searchCountries(by: "eu")

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "France")
        XCTAssertEqual(result.last?.name, "Germany")
    }
}
