//
//  LocationManagerTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import CoreLocation
import XCTest
@testable import CountryApp

final class LocationManagerTests: XCTestCase {
    private var mockManager: MockCLLocationManager!
    private var service: LocationManager!

    override func setUp() {
        super.setUp()
        mockManager = MockCLLocationManager()
        service = LocationManager(manager: mockManager)
    }
    


    func testGetCountryCode_whenAuthorized_shouldReturnCode() async {
        mockManager.mockCountryCode = "EG"
        mockManager.mockAuthorizationStatus = .authorizedWhenInUse

        let code = await service.getCountryCode()

        XCTAssertEqual(code, "EG")
    }

    func testGetCountryCode_whenDenied_shouldReturnNil() async {
        mockManager.mockAuthorizationStatus = .denied

        let code = await service.getCountryCode()

        XCTAssertNil(code)
    }
}

final class MockCLLocationManager: CLLocationManager {
    var mockCountryCode: String?
    var mockAuthorizationStatus: CLAuthorizationStatus = .authorizedWhenInUse
    
    override var authorizationStatus: CLAuthorizationStatus {
        return mockAuthorizationStatus
    }
    
    override class func authorizationStatus() -> CLAuthorizationStatus {
        return MockCLLocationManager().mockAuthorizationStatus
    }

    override func requestWhenInUseAuthorization() {
    }

    override func startUpdatingLocation() {
        delegate?.locationManager?(self, didUpdateLocations: [mockLocation()])
    }

    private func mockLocation() -> CLLocation {
        CLLocation(latitude: 30.0444, longitude: 31.2357)
    }

    override var delegate: CLLocationManagerDelegate? {
        get { super.delegate }
        set { super.delegate = newValue }
    }
}
