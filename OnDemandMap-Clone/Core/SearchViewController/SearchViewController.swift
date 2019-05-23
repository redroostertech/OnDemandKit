import UIKit

class SearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var searchTextField: UITextField!
    
    // MARK: - Customizable Properties
    var searchPlaceholderText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Class Methods
    func configureTextField() {
        searchTextField.placeholder = searchPlaceholderText
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
