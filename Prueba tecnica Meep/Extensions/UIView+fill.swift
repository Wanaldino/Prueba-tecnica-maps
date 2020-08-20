//
//  UIView+fill.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 17/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

extension UIView {
    func fill(with view: UIView, _ edges: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: edges.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edges.bottom),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edges.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edges.right)
        ])
    }
}
