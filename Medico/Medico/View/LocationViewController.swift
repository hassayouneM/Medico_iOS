//
//  LocationViewController.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 17/5/2022.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
        mapView.showsUserLocation = true
        
        if isLocationServiceEnabled() {
            checkAuthorization()
        } else {
            showAlert(msg: "Please enable location service")
            
        }
        
        //let initialLoc = CLLocation(latitude: 33.8869, longitude: 9.5375)
        
        //setStartingLocation(location: initialLoc, distance: 1000)

    }
    
    /*func setStartingLocation(location: CLLocation, distance: CLLocationDistance) {
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        
    }*/
    
    func isLocationServiceEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            //locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(msg: "Please authorize access to location")
            break
        case .restricted:
            showAlert(msg: "Authorization restricted")
            break
        default:
            print("Default ..")
            break
        }
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location: \(location.coordinate)")
            zoomToUserLocation(location: location)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func zoomToUserLocation(location : CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .notDetermined:
            //locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(msg: "Please authorize access to location")
            break
        default:
            print("Default ..")
            break
        }
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        alert.addAction(UIAlertAction(title: "settings", style: .default, handler: { action in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setStartingLocation(location: CLLocation, distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        //mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange =
        MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 30000000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }

}
