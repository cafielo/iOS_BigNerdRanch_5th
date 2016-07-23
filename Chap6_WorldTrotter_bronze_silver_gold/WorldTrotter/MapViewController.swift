//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Joonwon Lee on 7/20/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var zoominButton: UIButton!
    @IBOutlet weak var zoomoutButton: UIButton!
    
//    var pointOfInterests: [MKAnotation]
    
    
    
    var myLocation: CLLocation?
    var span: MKCoordinateSpan?
    var viewRegion: MKCoordinateRegion?
    
    let locationManager = CLLocationManager()

}

//UIViewController
extension MapViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewRegion()
        requestLocationPermission()
        updateCurrentUserLocation()
        startUpdateLocation()
        initZoomButtons()
    }
}

//private 
extension MapViewController {
    private func initZoomButtons() {
        zoominButton.layer.borderColor = UIColor.blueColor().colorWithAlphaComponent(0.7).CGColor
        zoominButton.layer.borderWidth = 0.5
        zoomoutButton.layer.borderColor = UIColor.blueColor().colorWithAlphaComponent(0.7).CGColor
        zoomoutButton.layer.borderWidth = 0.5
    }
    
    private func addAnnotations() {
        let poi1 = CLLocationCoordinate2D(latitude: 37.362232, longitude: 127.105380)
        let poi2 = CLLocationCoordinate2D(latitude: 37.360945, longitude: 127.106406)
        var pois = [poi1, poi2]
        
        if let currentMyLocation = myLocation?.coordinate {
            pois.append(currentMyLocation)
        }
        
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        
        pois.forEach {
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = $0
            
            mapView.addAnnotation(pointAnnotation)
//            mapView.centerCoordinate = pointAnnotation.coordinate
            mapView.selectAnnotation(pointAnnotation, animated: true)
        }
    }
}

//IBAction
extension MapViewController {
    
    @IBAction func mapTypeChanged(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    @IBAction func zoominButtonTapped(sender: AnyObject) {
        guard span != nil else {
            return
        }
        
        let currentLatSpanDelta = span?.latitudeDelta ?? 0.05
        let currentLongSpanDelta = span?.longitudeDelta ?? 0.05
        span = MKCoordinateSpan(latitudeDelta: max(currentLatSpanDelta - 0.02, 0), longitudeDelta: max(currentLongSpanDelta - 0.02, 0))
        updateCurrentUserLocation()
    }
    
    @IBAction func zoomoutButtonTapped(sender: AnyObject) {
        guard span != nil else {
            return
        }
        
        let currentLatSpanDelta = span?.latitudeDelta ?? 0.05
        let currentLongSpanDelta = span?.longitudeDelta ?? 0.05
        span = MKCoordinateSpan(latitudeDelta: min(currentLatSpanDelta + 0.02, 1), longitudeDelta: min(currentLongSpanDelta + 0.02, 1))
        updateCurrentUserLocation()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            myLocation = locations.first!
            updateCurrentUserLocation()
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let pinView = MKPinAnnotationView()
        pinView.annotation = annotation
        pinView.pinTintColor = UIColor.redColor()
        pinView.animatesDrop = true
        pinView.canShowCallout = true
        
        return pinView
    }
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView, fullyRendered: Bool) {
        addAnnotations()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    private func startUpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func requestLocationPermission() {
        // request a permission to get location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
    }
    
    private func initViewRegion() {
        myLocation = CLLocation()
        span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        viewRegion = MKCoordinateRegionMake(myLocation!.coordinate, span!)
        mapView.setRegion(viewRegion!, animated: true)
        
        // show current user location
        mapView.showsUserLocation = true
    }
    
    private func updateCurrentUserLocation() {
        
        let currentLatSpanDelta = span?.latitudeDelta ?? 0.05
        let currentLongSpanDelta = span?.longitudeDelta ?? 0.05
        span = MKCoordinateSpan(latitudeDelta: currentLatSpanDelta, longitudeDelta: currentLongSpanDelta)
        viewRegion = MKCoordinateRegionMake(myLocation!.coordinate, span!)
        mapView.setRegion(viewRegion!, animated: true)
    }
}