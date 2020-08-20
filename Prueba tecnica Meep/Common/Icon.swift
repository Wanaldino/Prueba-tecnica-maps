//
//  Icon.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 20/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

enum Icon: String {
    case bike = "bike"
    case pin = "pin"
    case bikeStation = "bikeStation"
}

extension UIImage {
    convenience init?(icon: Icon) {
        self.init(named: icon.rawValue)
    }
}
