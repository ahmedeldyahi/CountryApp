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

    var region: String?
    var subregion: String?
    var population: Int?
    var area: Double?
    var timezones: [String]?
    var latitude: Double?
    var longitude: Double?

    init(from country: Country) {
        self.id = country.id
        self.name = country.name
        self.capital = country.capital
        self.currency = country.currency
        self.flagURL = country.flagURL
        self.code = country.code

        self.region = country.region
        self.subregion = country.subregion
        self.population = country.population
        self.area = country.area
        self.timezones = country.timezones
        self.latitude = country.latitude
        self.longitude = country.longitude
    }

    func toCountry() -> Country {
        Country(
            name: name,
            capital: capital,
            currency: currency,
            flagURL: flagURL,
            code: code,
            region: region,
            subregion: subregion,
            population: population,
            area: area,
            timezones: timezones,
            latitude: latitude,
            longitude: longitude
        )
    }
}
