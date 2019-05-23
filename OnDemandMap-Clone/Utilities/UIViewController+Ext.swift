import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return identifier
    }
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
