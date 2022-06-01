//
//  LocationService.swift
//  Coffee Pack
//
//  Created by Hugo Paulista on 31/05/22.
//

import Foundation
import CoreLocation

let DISTANCE: NSNumber = 1600

class LocationService {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    private var isLocationAuthorized: Bool = false
    
    // MARK: - Authorization
    
    private func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func authorized() -> Bool {
        isLocationAuthorized = Bool(truncating: locationManager.authorizationStatus.rawValue as NSNumber)
        return isLocationAuthorized
    }
    
    func handleMapAuthorization() {
        if !authorized() {
            requestAuthorization()
        }
    }
    
    // MARK: - Geolocation
    
    func getCoords() -> CLLocationCoordinate2D {
        guard let location = locationManager.location else { return CLLocationCoordinate2D() }
        return location.coordinate
    }
    
    func getLocationDisance() -> CLLocationDistance? {
        return CLLocationDistance(exactly: DISTANCE)
    }
}
