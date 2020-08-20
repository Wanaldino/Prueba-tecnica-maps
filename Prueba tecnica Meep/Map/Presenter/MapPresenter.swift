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
    
    func transformMarkers(_ markers: [MapMarker]) -> [GMSMarker] {
        let blueImage = GMSMarker.markerImage(with: .blue)
        let greenImage = GMSMarker.markerImage(with: .green)
        let yellowImage = GMSMarker.markerImage(with: .yellow)
        
        return markers.compactMap { (marker) -> GMSMarker? in
            let position = CLLocationCoordinate2D(
                latitude: marker.y,
                longitude: marker.x
            )
            let gmsMarker = GMSMarker(position: position)
            
            switch marker.markerType {
            case .location:
                gmsMarker.title = marker.name
                gmsMarker.icon = blueImage
                return gmsMarker
            case .bikeStation(let data):
                gmsMarker.title = "Bike Station \(marker.name)"
                gmsMarker.snippet = "Available bikes: \(data.bikesAvailable)"
                gmsMarker.icon = greenImage
                return gmsMarker
            case .motorbike(let data):
                gmsMarker.title = "Motorbike \(data.model)"
                gmsMarker.snippet = "Helmets: \(data.helmets)"
                gmsMarker.icon = yellowImage
                return gmsMarker
            case .unknown:
                return nil
            }
        }
    }
}

extension MapPresenter: MapPresenterProtocol {
    var model: MapViewModel {
        return .init(
            mapDelegate: self
        )
    }
}

extension MapPresenter: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let projection = mapView.projection.visibleRegion()
        
        interactor.getMarkers(
            southWestLatLon: projection.nearLeft,
            northEastLatLon: projection.farRight
        ) { markers in
            self.transformMarkers(markers).forEach { (marker) in
                marker.map = mapView
            }
        }
    }
}

