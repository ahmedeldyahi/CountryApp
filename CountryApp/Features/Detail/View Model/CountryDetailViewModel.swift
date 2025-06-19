//
//  CountryDetailViewModel.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import SwiftUI

struct CountryDetailViewModel {
    let country: Country

    var detailItems: [CountryDetailItem] {
        var items: [CountryDetailItem] = [
            .init(icon: "building.2.fill", label: "Capital", value: country.capital, color: .blue),
            .init(icon: "dollarsign.circle.fill", label: "Currency", value: country.currency, color: .green)
        ]

        if let region = country.region {
            items.append(.init(icon: "globe", label: "Region", value: region, color: .orange))
        }
        if let subregion = country.subregion {
            items.append(.init(icon: "map.fill", label: "Subregion", value: subregion, color: .purple))
        }
        if let population = country.population {
            items.append(.init(icon: "person.3.fill", label: "Population", value: population.formatted(), color: .pink))
        }
        if let area = country.area {
            items.append(.init(icon: "square.fill", label: "Area", value: "\(area.formatted()) km²", color: .teal))
        }
        if let timezones = country.timezones {
            items.append(.init(icon: "clock.fill", label: "Timezones", value: timezones.joined(separator: ", "), color: .indigo))
        }

        return items
    }
}

struct CountryDetailItem: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    let value: String
    let color: Color
}
