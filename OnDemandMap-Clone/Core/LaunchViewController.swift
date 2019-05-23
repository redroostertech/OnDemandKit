import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet private weak var launchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func launch(_ sender: UIButton) {
        let destinationVC = MapViewController()
        //  MARK:- Optional setup properties
        //  destinationVC.defaultViewType = .map
        //  destinationVC.isMultiViewType = false
        present(destinationVC, animated: true, completion: nil)
    }
}
