//
//  CountryDetailView.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country
    
    var body: some View {
            ScrollView {
                VStack(spacing: 30) {
                    mapView
                    infoCard
                }
                .padding(.bottom, 30)
            }
        
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var mapView: some View {
            CountryMapView(lat: country.latitude ?? 0, long: country.longitude ?? 0, countryName: country.name)
    }
    
    private var flagHeader: some View {
        AsyncImage(url: URL(string: country.flagURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)

            default:
                EmptyView()
            }
        }
    }
    
    private var placeholderFlag: some View {
        ZStack {
            Color(.systemGray5)
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .foregroundColor(.secondary)
        }
        .frame(height: 240)
    }
    
    private var infoCard: some View {
        VStack(spacing: 0) {
            HStack {
                flagHeader
                Text("Country Information")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            
            VStack(spacing: 16) {
                DetailRow(
                    icon: "building.2.fill",
                    label: "Capital",
                    value: country.capital,
                    color: .blue
                )
                
                DetailRow(
                    icon: "dollarsign.circle.fill",
                    label: "Currency",
                    value: country.currency,
                    color: .green
                )
                
                if let region = country.region {
                    DetailRow(
                        icon: "globe",
                        label: "Region",
                        value: region,
                        color: .orange
                    )
                }
                
                if let subregion = country.subregion {
                    DetailRow(
                        icon: "map.fill",
                        label: "Subregion",
                        value: subregion,
                        color: .purple
                    )
                }
                
                if let population = country.population {
                    DetailRow(
                        icon: "person.3.fill",
                        label: "Population",
                        value: population.formatted(),
                        color: .pink
                    )
                }
                
                if let area = country.area {
                    DetailRow(
                        icon: "square.fill",
                        label: "Area",
                        value: "\(area.formatted()) km²",
                        color: .teal
                    )
                }
                
                if let timezones = country.timezones {
                    DetailRow(
                        icon: "clock.fill",
                        label: "Timezones",
                        value: timezones.joined(separator: ", "),
                        color: .indigo
                    )
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 4)
    }
}

private struct DetailRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
    }
}


// MARK: - Preview
struct CountryDetailView_Previews: PreviewProvider {
    static var previewCountry: Country {
        Country(
            name: "Egypt",
            capital: "Cairo",
            currency: "Egyptian Pound",
            flagURL: "https://flagcdn.com/w320/eg.png",
            code: "EGY",
            region: "Africa",
            subregion: "Northern Africa",
            population: 102_334_000,
            area: 1_002_450,
            timezones: ["UTC+02:00"],
            latitude: 20.0,
            longitude: 30.0
        )
    }
    
    static var previews: some View {
        NavigationStack {
            CountryDetailView(country: previewCountry)
        }
        .previewDisplayName("Detail View")
    }
}
