//
//  MapInteractor.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 16/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import CoreLocation

class MapInteractor {
    let dataManager: MapDataManagerProtocol
    var markers = [MapMarker]()
    
    init(dataManager: MapDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension MapInteractor: MapInteractorProtocol {
    func getMarkers(southWestLatLon: CLLocationCoordinate2D, northEastLatLon: CLLocationCoordinate2D, completion: @escaping ([MapMarker]) -> Void) {
        let southWestLatLon = String(format: "%@,%@", southWestLatLon.latitude, southWestLatLon.longitude)
        let northEastLatLon = String(format: "%@,%@", northEastLatLon.latitude, northEastLatLon.longitude)
        
        let model = MarkersRequestModel(
            city: "lisboa",
            lowerLeftLatLon: southWestLatLon,
            upperRightLatLon: northEastLatLon
        )
        dataManager.getMarkers(for: model) { (result) in
            switch result {
            case .success(let markers):
                markers.forEach { (marker) in
                    if !self.markers.contains(where: { $0.id == marker.id }) {
                        self.markers.append(marker)
                    }
                }
                completion(self.markers)
            case .failure:
                break
            }
        }
    }
}
