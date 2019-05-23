import Foundation
import CoreLocation
import MapKit

public var DefaultZoom = 0.2

protocol LocationManagerDelegate {
    func willRetrieveLocation(_ manager: LocationManager, location: CLLocation, center: CLLocationCoordinate2D, region: MKCoordinateRegion)
    func willShowError(_ manager: LocationManager, error: Error?)
}

extension LocationManagerDelegate {
    func willShowError(_ manager: LocationManager, error: Error?) { }
}

class LocationManager: NSObject {
    fileprivate let locationManager = CLLocationManager()
    var delegate: LocationManagerDelegate?
    var baseSpan: Double = 0.01
    var isAuthorized: Bool = false {
        didSet {
            locationManager.requestLocation()
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestWhenInUse() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.isAuthorized = true
        default:
            self.isAuthorized = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Location captured")
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: DefaultZoom, longitudeDelta: DefaultZoom))
            delegate?.willRetrieveLocation(self, location: location, center: center, region: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

