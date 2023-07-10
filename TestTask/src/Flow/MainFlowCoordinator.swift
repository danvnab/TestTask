//
//  Coordinator.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation
import UIKit

protocol MainFlowCoordinatorProtocol: BaseFlowCoordinator { }

protocol MainFlowCoordinatorDelegate: AnyObject { }

final class MainFlowCoordinator: MainFlowCoordinatorProtocol {
    
    var childCoordinators: [BaseFlowCoordinator] = []
    var viewController: UINavigationController?
    
    func launchViewController() -> UIViewController? {
        let vc = CategoryScreenViewController()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        self.viewController = nc
        return nc
    }
}

extension MainFlowCoordinator: CategoryScreenViewControllerDelegate {
    func showBooksList(name: String, title: String) {
        let vc = BooksScreenViewController()
        vc.featchData(listName: name, title: title)
        vc.booksDelegate = self
        viewController?.pushViewController(vc, animated: true)
    }
}

extension MainFlowCoordinator: BooksScreenViewControllerDelegate {
    func openBuyView(links: [BuyLink]) {
        let vc = BooksPopUpViewController()
        vc.fetchData(model: links)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        viewController?.topViewController?.present(vc, animated: true)
    }
}

extension MainFlowCoordinator: BooksPopUpViewControllerDelegate {
    func showShop(url: String) {
        let vc = WebViewController()
        vc.loadRequest(urlString: url)
        viewController?.pushViewController(vc, animated: true)
    }
}
