//
//  Coordinator.swift
//  itau
//
//  Created by André Lucas on 12/09/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    func start()
    
}
