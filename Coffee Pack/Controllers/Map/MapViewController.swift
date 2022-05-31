//
//  MapViewController.swift
//  Coffee Pack
//
//  Created by Hugo Paulista on 31/05/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    

    // MARK: - IBOutlets
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    // MARK: - Services
    private let locationService: LocationService = LocationService()
    
    // MARK: - Declarations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()

    }
    
    func setupMap() {
        locationService.handleMapAuthorization()
        guard let distance = locationService.getLocationDisance() else { return }
        let coords = locationService.getCoords()
        let region = MKCoordinateRegion(center: coords, latitudinalMeters: distance, longitudinalMeters: distance)
        mapViewOutlet.setRegion(region, animated: true)
        mapViewOutlet.setCenter(coords, animated: true)
        mapViewOutlet.showsUserLocation = true
        mapViewOutlet.pointOfInterestFilter = .excludingAll
        mapViewOutlet.mapType = .mutedStandard
        
        addAnnotations()
    }
    
    func addAnnotations() {
        // -26.9184895,-48.6528877
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: -26.9184895, longitude: -48.6528877)
        annotation.title = "Pizzaria"
        mapViewOutlet.addAnnotation(annotation)
    }
 }

