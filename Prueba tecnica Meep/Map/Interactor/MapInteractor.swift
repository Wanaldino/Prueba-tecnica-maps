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
    
    func clearAndSaveMarkers(_ markers: [MapMarker]) -> [MapMarker] {
        var savedMarkersID = self.markers.compactMap({ $0.id })
        
        let clearedMarkers = markers.reduce([MapMarker]()) { (result, marker) -> [MapMarker] in
            if savedMarkersID.contains(marker.id) {
                return result
            } else {
                var newResult = result
                newResult.append(marker)
                savedMarkersID.append(marker.id)
                return newResult
            }
        }
        
        self.markers.append(contentsOf: clearedMarkers)
        
        return clearedMarkers
    }
}

extension MapInteractor: MapInteractorProtocol {
    func getMarkers(southWestLatLon: CLLocationCoordinate2D, northEastLatLon: CLLocationCoordinate2D, completion: @escaping ([MapMarker]) -> Void) {
        let southWestLatLon = String("\(southWestLatLon.latitude),\(southWestLatLon.longitude)")
        let northEastLatLon = String("\(northEastLatLon.latitude),\(northEastLatLon.longitude)")
        
        let model = MarkersRequestModel(
            city: "lisboa",
            lowerLeftLatLon: southWestLatLon,
            upperRightLatLon: northEastLatLon
        )
        dataManager.getMarkers(for: model) { (result) in
            switch result {
            case .success(let markers):
                let clearedMarkers = self.clearAndSaveMarkers(markers)
                completion(clearedMarkers)
            case .failure:
                break
            }
        }
    }
}
