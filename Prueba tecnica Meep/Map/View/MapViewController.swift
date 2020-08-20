//
//  MapViewController.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 16/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import UIKit
import GoogleMaps

var latitude = 38.739429
var longitude = -9.160096

class MapViewController: UIViewController {
    
    lazy var map: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        let map = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.settings.compassButton = true
        map.delegate = model.mapDelegate
        return map
    }()
    var presenter: MapPresenterProtocol
    var model: MapViewModel
    
    init(presenter: MapPresenterProtocol) {
        self.presenter = presenter
        self.model = presenter.model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.fill(with: map)
    }
}

extension MapViewController: MapViewProtocol {
    func update() {
        model = presenter.model
    }
}
