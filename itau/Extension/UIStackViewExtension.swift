//
//  UIStackViewExtension.swift
//  itau
//
//  Created by André Lucas on 13/09/21.
//

import UIKit

extension UIStackView {
    func addArrangeSubViews(_ views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false}
        views.forEach { addArrangedSubview($0)}
    }
}
