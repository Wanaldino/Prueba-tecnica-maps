//
//  MapDataManager.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 16/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

class MapDataManager {
    
    init() {}
    
    func getData() {
        
    }
}

extension MapDataManager: MapDataManagerProtocol {
    func getMarkers(for request: MarkersRequestModel, completion: @escaping (Result<[MapMarker], Error>) -> Void) {
        
        let fileURL = Bundle.main.url(forResource: "mock", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let results = try! JSONDecoder().decode([MapMarker].self, from: data)
        return completion(.success(results))
        
        let urlString = String(format: "https://apidev.meep.me/tripplan/api/v1/routers/%@/resources", request.city)
        var urlComponents = URLComponents(string: urlString)
        
        urlComponents?.queryItems?.append(.init(name: "lowerLeftLatLon", value: request.lowerLeftLatLon))
        urlComponents?.queryItems?.append(.init(name: "upperRightLatLon", value: request.upperRightLatLon))
        
        var urlRequest = URLRequest(url: urlComponents!.url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let results = try? JSONDecoder().decode([MapMarker].self, from: data) {
                completion(.success(results))
            } else {
                fatalError()
            }
        }
    }
}
