//
//  CachedCountry.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//


import Foundation
import SwiftData

@Model
class CachedCountry {
    var id: String
    var name: String
    var capital: String
    var currency: String
    var flagURL: String
    var code: String

    init(from country: Country) {
        self.id = country.id
        self.name = country.name
        self.capital = country.capital
        self.currency = country.currency
        self.flagURL = country.flagURL
        self.code = country.code
    }

    func toCountry() -> Country {
        Country(
            name: name,
            capital: capital,
            currency: currency,
            flagURL: flagURL,
            code: code,
            region: nil,
            subregion: nil,
            population: nil,
            area: nil,
            timezones: nil,
            latitude: nil,
            longitude: nil
        )
    }
}
