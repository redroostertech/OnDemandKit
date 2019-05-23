import UIKit
import CoreLocation
import MapKit

public enum ViewType {
    case list
    case map
}

public let kDefaultSearchPlaceholderText = "Search"
public let kDefaultSearchIcon = "search-sm"
public let kDefaultListIcon = "list"
public let kDefaultMapIcon = "map"
public let kDefaultRecenterIcon = "recenter"

class MapViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var recenterButton: UIButton!
    @IBOutlet private weak var toggleViewTypeButton: UIButton!
    
    // MARK: - Objects
    private var locationManger: LocationManager?
    
    // MARK: - Custom Views
    private var customMapView: CustomMapView?
    
    // MARK: - Customizable Properties
    var defaultViewType: ViewType = .map
    var searchPlaceholderText = kDefaultSearchPlaceholderText
    var isMultiViewType = true
    var searchIconName = kDefaultSearchIcon
    var listIconName = kDefaultListIcon
    var mapIconName = kDefaultMapIcon
    var recenterIconName = kDefaultRecenterIcon
    
    // MARK: - Lifecycle Methods
    // TODO: - Identify items that need to be loaded before view comes into play
    init() {
        super.init(nibName: MapViewController.identifier, bundle: nil)
        locationManger = LocationManager()
        locationManger?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger?.requestWhenInUse()
        
        switch defaultViewType {
        case .map:
            self.loadMap()
            self.recenterButton.isHidden = false
            if isMultiViewType {
                self.setToggleImage(listIconName)
            } else {
                self.setToggleImage(mapIconName)
            }
        case .list:
            self.recenterButton.isHidden = true
            if isMultiViewType {
                self.setToggleImage(mapIconName)
            } else {
                self.setToggleImage(listIconName)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUI()
    }
    
    // MARK: - Class Methods
    func loadMap() {
        customMapView = CustomMapView(containerView, andDelegate: self)
        customMapView?.showMap()
    }
    
    func configureUI() {
        searchButton.setTitle(searchPlaceholderText,
                              for: .normal)
        searchButton.setImage(UIImage(named: searchIconName),
                              for: .normal)
        recenterButton.setImage(UIImage(named: recenterIconName),
                                for: .normal)
    }
    
    func setToggleImage(_ imagename: String) {
        toggleViewTypeButton.setImage(UIImage(named: imagename), for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func recenterMap(_ sender: UIButton) {
        customMapView?.centerWithDefaultZoom()
    }
    
    @IBAction func startSearch(_ sender: UIButton) {
        let destinationVC = SearchViewController()
        show(destinationVC,sender: self)
    }
    
    @IBAction func toggleViews(_ sender: UIButton) {
        if isMultiViewType {
            switch defaultViewType {
            case .list:
                self.defaultViewType = .map
                self.loadMap()
                self.recenterMap(sender)
                self.recenterButton.isHidden = false
                self.setToggleImage(listIconName)
            case .map:
                self.defaultViewType = .list
                self.customMapView?.removeMap {
                    self.customMapView = nil
                    self.recenterButton.isHidden = true
                    self.setToggleImage(mapIconName)
                }
            }
        } else {
            print("Multi view type is not selected.")
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: LocationManagerDelegate {
    func willRetrieveLocation(_ manager: LocationManager, location: CLLocation, center: CLLocationCoordinate2D, region: MKCoordinateRegion) {
        customMapView?.setCenterAndRegion(center: center, region: region)
    }
}
