//
//  BaseCoordinator.swift
//  TestTask
//
//  Created by Danil Velanskiy on 06.07.2023.
//

import Foundation
import UIKit

protocol BaseFlowCoordinator: AnyObject {
    var childCoordinators: [BaseFlowCoordinator] { get set }
    
    func launchViewController() -> UIViewController?
    func addChildCoordinator(_ coordinator: BaseFlowCoordinator)
}

extension BaseFlowCoordinator {
    func addChildCoordinator(_ coordinator: BaseFlowCoordinator) {
        childCoordinators.append(coordinator)
    }
}
