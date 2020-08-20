//
//  MapDataManagerProtocol.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 17/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

protocol MapDataManagerProtocol: class {
    func getMarkers(for request: MarkersRequestModel, completion: @escaping (Result<[MapMarker], Error>) -> Void)
}
