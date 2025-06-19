//
//  CountryDetailView.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country
    private var viewModel: CountryDetailViewModel {
        CountryDetailViewModel(country: country)
    }
    
    var body: some View {
            ScrollView {
                VStack(spacing: 30) {
                    mapView
                    infoCard
                    .padding(.horizontal)
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
                ForEach(viewModel.detailItems) { item in
                    DetailRow(icon: item.icon, label: item.label, value: item.value, color: item.color)
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


