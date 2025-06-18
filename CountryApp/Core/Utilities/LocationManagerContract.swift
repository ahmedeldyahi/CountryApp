//
//  LocationManagerContract.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//


import Foundation
import CoreLocation
import Combine

protocol LocationManagerContract {
    func getCountryCode() async -> String?
}

final class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerContract {
    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<String?, Never>?
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }

    func getCountryCode() async -> String? {
        let authStatus = CLLocationManager.authorizationStatus()
        
        switch authStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            return nil
        default:
            break
        }

        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        
        return await withCheckedContinuation { continuation in
            self.continuation = continuation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            continuation?.resume(returning: nil)
            continuation = nil
            return
        }

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let countryCode = placemarks?.first?.isoCountryCode {
                self.continuation?.resume(returning: countryCode)
            } else {
                self.continuation?.resume(returning: nil)
            }

            self.continuation = nil
            self.locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(returning: nil)
        continuation = nil
    }
}
