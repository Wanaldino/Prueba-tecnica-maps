//
//  MapBuilder.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 16/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit

class MapBuilder: Builder {
    func build() -> UIViewController {
        let dataManager = MapDataManager()
        let interactor = MapInteractor(dataManager: dataManager)
        let presenter = MapPresenter(interactor: interactor)
        let viewController = MapViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
