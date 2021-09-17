//
//  MainCoordinator.swift
//  itau
//
//  Created by André Lucas on 12/09/21.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = JavaRepoPopViewModel()
        let vc = JavaRepoPopController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
