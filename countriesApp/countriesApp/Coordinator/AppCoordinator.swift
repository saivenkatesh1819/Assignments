
import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()-> UINavigationController
   
}

final class MainCoordinator: Coordinator {
    
    private let navigationController = UINavigationController()
    
    
    func start()-> UINavigationController {
        let controller = CountriesViewController()
        controller.coordinator = self
        navigationController.viewControllers = [controller]
        return navigationController
    }
    
}
