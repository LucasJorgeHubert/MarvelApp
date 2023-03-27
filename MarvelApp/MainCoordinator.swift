import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func pop()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func start() {
        let vm = LoginViewModel(coordinator: self)
        let vc = LoginViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openApp() {
        let vm = ListHQsViewModel(coordinator: self)
        let vc = ListHQsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openHQDetail(hq: HQ) {
        let vm = DetailHQViewModel(coordinator: self, hq: hq)
        let vc = DetailHQViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
}
