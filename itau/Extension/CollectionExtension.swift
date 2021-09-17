//
//  CollectionExtension.swift
//  itau
//
//  Created by André Lucas on 13/09/21.
//

import UIKit

extension Collection where Self.Element == NSLayoutConstraint {
    func activate() {
        forEach { $0.isActive = true}
    }
}
