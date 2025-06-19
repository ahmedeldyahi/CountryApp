//
//  CountryDetailViewModelTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import XCTest
@testable import CountryApp

final class CountryDetailViewModelTests: XCTestCase {
    func testDetailItems_shouldIncludeExpectedFields() {
        let country = Country(
            name: "Italy",
            capital: "Rome",
            currency: "EUR",
            flagURL: "https://flagcdn.com/it.svg",
            code: "IT",
            region: "Europe",
            subregion: "Southern Europe",
            population: 60000000,
            area: 301230,
            timezones: ["UTC+1"],
            latitude: nil,
            longitude: nil
        )

        let viewModel = CountryDetailViewModel(country: country)
        let items = viewModel.detailItems

        XCTAssertEqual(items.count, 7)
        XCTAssertTrue(items.contains(where: { $0.label == "Capital" && $0.value == "Rome" }))
        XCTAssertTrue(items.contains(where: { $0.label == "Currency" && $0.value == "EUR" }))
        XCTAssertTrue(items.contains(where: { $0.label == "Region" && $0.value == "Europe" }))
        XCTAssertTrue(items.contains(where: { $0.label == "Subregion" && $0.value == "Southern Europe" }))
        XCTAssertTrue(items.contains(where: { $0.label == "Population" && $0.value.contains("60") }))
        XCTAssertTrue(items.contains(where: { $0.label == "Area" && $0.value.contains("301") }))
        XCTAssertTrue(items.contains(where: { $0.label == "Timezones" && $0.value.contains("UTC+1") }))
    }
}
