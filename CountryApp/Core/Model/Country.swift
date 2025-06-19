//
//  Country.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

struct Country: Codable, Identifiable, Equatable, Hashable {
    var id: String { code }
    let name: String
    let capital: String
    let currency: String
    let flagURL: String
    let code: String

    let region: String?
    let subregion: String?
    let population: Int?
    let area: Double?
    let timezones: [String]?
    let latitude: Double?
    let longitude: Double?
}


struct CountryModel: Decodable {
    struct Name: Decodable { let common: String }
    struct Flags: Decodable { let png: String }
    struct Currency: Decodable { let name: String }

    let name: Name
    let capital: [String]?
    let currencies: [String: Currency]?
    let flags: Flags
    let cca3: String

    
    let region: String?
    let subregion: String?
    let population: Int?
    let area: Double?
    let timezones: [String]?
    let latlng: [Double]?
    
    func toCountry() -> Country? {
        guard let capital = capital?.first,
              let currency = currencies?.first?.value.name else { return nil }
        
        let latitude = latlng?.first
        let longitude = latlng?.count ?? 0 > 1 ? latlng?[1] : nil

        return Country(
            name: name.common,
            capital: capital,
            currency: currency,
            flagURL: flags.png,
            code: cca3,
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
