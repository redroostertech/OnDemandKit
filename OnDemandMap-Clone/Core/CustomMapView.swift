import UIKit
import CoreLocation
import MapKit

class CustomMapView: UIView {
    private var map: MKMapView!
    private var container: UIView!
    
    init(_ containerView: UIView, andDelegate delegate: MKMapViewDelegate) {
        super.init(frame: containerView.frame)
        container = containerView
        map = MKMapView(frame: containerView.frame)
        map.delegate = delegate
        map.showsUserLocation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMap() {
        container.addSubview(map)
    }
    
    func setCenterAndRegion(center: CLLocationCoordinate2D, region: MKCoordinateRegion) {
        map.setCenter(center, animated: true)
        map.setRegion(region, animated: true)
    }
    
    func center() {
        map.setCenter(map.userLocation.coordinate, animated: true)
    }
    
    func centerWithDefaultZoom() {
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: DefaultZoom, longitudeDelta: DefaultZoom))
        map.setCenter(map.userLocation.coordinate, animated: true)
        map.setRegion(region, animated: true)
    }
    
    func removeMap(_ completion: ()->Void) {
        map.removeFromSuperview()
        completion()
    }
}
