//
//  MapInteractorProtocol.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 17/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import CoreLocation

protocol MapInteractorProtocol: class {
    func getMarkers(southWestLatLon: CLLocationCoordinate2D, northEastLatLon: CLLocationCoordinate2D, completion: @escaping ([MapMarker]) -> Void)
}
