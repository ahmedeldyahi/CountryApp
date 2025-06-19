//
//  CountryRow.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import SwiftUI

struct CountryRow: View {
    let country: Country
    
    var body: some View {
        HStack(spacing: 20) {
            flagView
            VStack(alignment: .leading, spacing: 4) {
                Text(country.name)
                    .font(.headline)
                Text("Capital: \(country.capital)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Currency: \(country.currency)")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(country.name), capital \(country.capital), currency \(country.currency)")
    }
    
    private var flagView: some View {
           Group {
               if let url = URL(string: country.flagURL) {
                   AsyncImage(url: url) { phase in
                       switch phase {
                       case .success(let image):
                           image
                               .resizable()
                               .scaledToFill()
                       case .failure:
                           placeholderFlag
                       case .empty:
                           ProgressView()
                       @unknown default:
                           placeholderFlag
                       }
                   }
               } else {
                   placeholderFlag
               }
           }
           .frame(width: 44, height: 44)
           .background(Color(.systemGray5))
           .clipShape(RoundedRectangle(cornerRadius: 8))
       }
    
    private var placeholderFlag: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 20)
            .foregroundColor(.gray)
    }
}

