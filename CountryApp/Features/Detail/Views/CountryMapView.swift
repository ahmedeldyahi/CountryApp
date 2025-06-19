//
//  CountryMapView.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import MapKit
import SwiftUI

struct CountryMapView: View {
    let lat: Double
    let long: Double
    let countryName: String
    @State private var region: MapCameraPosition
    private let coordinate: CLLocationCoordinate2D
    init(lat: Double, long: Double, countryName: String) {
        self.lat = lat
        self.long = long
        self.countryName = countryName
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let baseSpan: CLLocationDegrees = 8.0
        let adjustedSpan = min(max(baseSpan, 1.0), 30.0)
        let span = MKCoordinateSpan(latitudeDelta: adjustedSpan, longitudeDelta: adjustedSpan)
        
        _region = State(initialValue: .region(
            MKCoordinateRegion(center: coordinate, span: span)
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Map(position: $region) {
                    Marker(countryName, coordinate: coordinate)
                }
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )

                Button(action: openInMaps) {
                    Label("Open in Maps", systemImage: "location.fill")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding([.bottom,.horizontal], 4)
                }
            }
        }
        .padding()
    }

    private func openInMaps() {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = countryName
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

struct MapAnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    CountryMapView(lat: 30, long: 30, countryName: "Egypt")
}
