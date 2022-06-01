//
//  MapViewController.swift
//  Coffee Pack
//
//  Created by Hugo Paulista on 31/05/22.
//

import UIKit
import MapKit

let COMPANIES_PATH = "https://aqueous-citadel-64961.herokuapp.com/companies"

class MapViewController: UIViewController, MKMapViewDelegate {
    

    // MARK: - IBOutlets
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    // MARK: - Services
    private let locationService: LocationService = LocationService()
    private let companiesSerivce: CompaniesApiService = CompaniesApiService()
    
    // MARK: - Declarations
    private var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupMap()
    }
    
    func setupMap() {
        mapViewOutlet.delegate = self
        locationService.handleMapAuthorization()
        guard let distance = locationService.getLocationDisance() else { return }
        let coords = locationService.getCoords()
        let region = MKCoordinateRegion(center: coords, latitudinalMeters: distance, longitudinalMeters: distance)
        mapViewOutlet.setRegion(region, animated: true)
        mapViewOutlet.showsUserLocation = true
        mapViewOutlet.pointOfInterestFilter = .excludingAll
    }
    
    func getData() {
        companiesSerivce.getData(COMPANIES_PATH) { (result: [Company]) in
            self.companies = result
            self.addAnnotations()
        }
    }
    
    func addAnnotations() {
        for item in companies {
            guard let latitude = Double(item.lat) else { continue }
            guard let longitude = Double(item.long) else { continue }
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = item.name
            
            mapViewOutlet.addAnnotation(annotation)
        }

    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "Pin"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.markerTintColor = .black
            annotationView?.glyphTintColor = .systemGreen
            annotationView?.canShowCallout = true
            annotationView?.animatesWhenAdded = true
            
            let button = UIButton(type: .custom) as UIButton
            button.frame.size.width = 44
            button.frame.size.height = 44
            button.backgroundColor = .systemGreen
            button.setTitle("Teste", for: .normal)
            button.setTitleColor(.black, for: .normal)
            annotationView?.leftCalloutAccessoryView = button
            
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView;
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("clicouuuu")
    }
 }

