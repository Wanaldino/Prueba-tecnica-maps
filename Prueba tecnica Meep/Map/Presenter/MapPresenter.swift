//
//  MapPresenter.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 16/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation
import GoogleMaps

class MapPresenter: NSObject {
    weak var view: MapViewProtocol?
    let interactor: MapInteractorProtocol
    
    init(interactor: MapInteractorProtocol) {
        self.interactor = interactor
        super.init()
    }
}

extension MapPresenter: MapPresenterProtocol {
    var model: MapViewModel {
        return .init(
            mapDelegate: self,
            markers: [
                .init(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            ]
        )
    }
}

extension MapPresenter: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        guard let bounds = mapView.cameraTargetBounds else { return }
        
        interactor.getMarkers(
            southWestLatLon: bounds.southWest,
            northEastLatLon: bounds.northEast
        ) { _ in 
            self.view?.update()
        }
    }
}

