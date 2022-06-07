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
    private var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .dark
        }
        getData()
        setupMap()
    }
    
    func setupMap() {
        mapViewOutlet.delegate = self
        locationService.handleMapAuthorization()
        center = locationService.getCoords()
        setupCenter()
        setupCamera()
    }
    
    func getData() {
        companiesSerivce.getData(COMPANIES_PATH) { (result: [Company]) in
            self.companies = result
            self.addAnnotations()
        }
    }
    
    func addAnnotations() {
        for (index, item) in companies.enumerated() {
            guard let latitude = Double(item.lat) else { continue }
            guard let longitude = Double(item.long) else { continue }
            let annotation = Annotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = item.name
            annotation.index = index
            
            
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
            annotationView?.canShowCallout = false
            annotationView?.animatesWhenAdded = true
            
//            let button = UIButton(type: .custom) as UIButton
//            button.frame.size.width = 44
//            button.frame.size.height = 44
//            button.backgroundColor = .systemGreen
//            button.setTitle("Teste", for: .normal)
//            button.setTitleColor(.black, for: .normal)
//            annotationView?.leftCalloutAccessoryView = button
            
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView;
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let modalController = HomeCardViewController(nibName: "HomeCardViewController", bundle: nil)
        guard let annotation = view.annotation as? Annotation else { return }
        let company = companies[annotation.index]
        
        modalController.setContent(title: company.name, description: company.address, image: "")
        modalController.modalPresentationStyle = .pageSheet
        present(modalController, animated: true, completion: nil)
        
    }
    
    private func setupCenter() {
        guard let distance = locationService.getLocationDisance() else { return }
        let region = MKCoordinateRegion(center: center, latitudinalMeters: distance, longitudinalMeters: distance)
        mapViewOutlet.setRegion(region, animated: true)
        mapViewOutlet.showsUserLocation = true
        mapViewOutlet.pointOfInterestFilter = .excludingAll
    }
    
    private func setupCamera() {
        
        let mapCamera: MKMapCamera = mapViewOutlet.camera
        mapCamera.pitch = 45.0
        mapCamera.altitude = 1250.0
        mapViewOutlet.setCamera(mapCamera, animated: true)
    }
 }

