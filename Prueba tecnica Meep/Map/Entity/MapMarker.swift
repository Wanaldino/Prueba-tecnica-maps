//
//  MapMarker.swift
//  Prueba tecnica Meep
//
//  Created by Wanaldino Antimonio on 16/08/2020.
//  Copyright © 2020 Carlos Martinez Medina. All rights reserved.
//

import Foundation

struct MapMarker: Codable {
    let id: String
    let name: String
    let x: Double
    let y: Double
    let companyZoneId: Int
    let markerType: MapMarkerType
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        x = try values.decode(Double.self, forKey: .x)
        y = try values.decode(Double.self, forKey: .y)
        companyZoneId = try values.decode(Int.self, forKey: .companyZoneId)
        
        switch companyZoneId {
        case 402, 378, 382:
            markerType = .location(try Location(from: decoder))
        case 473:
            markerType = .motorbike(try Motorbike(from: decoder))
        case 412:
            markerType = .bikeStation(try BikeStation(from: decoder))
        default:
            markerType = .unknown
        }
    }
    
    enum MapMarkerType: Codable {
        case location(Location)
        case motorbike(Motorbike)
        case bikeStation(BikeStation)
        case unknown
        
        init(from decoder: Decoder) throws {
            fatalError()
        }
        
        func encode(to encoder: Encoder) throws {
            fatalError()
        }
    }
    
    struct Location: Codable {
        let scheduledArrival: Int
        let locationType: Int
        let lat: Double
        let lon: Double
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            scheduledArrival = try values.decode(Int.self, forKey: .scheduledArrival)
            locationType = try values.decode(Int.self, forKey: .locationType)
            lat = try values.decode(Double.self, forKey: .lat)
            lon = try values.decode(Double.self, forKey: .lon)
        }
    }
    
    struct Motorbike: Codable {
        let licencePlate: String
        let range: Int
        let helmets: Int
        let model: String
        let resourceImageId: String
        let realTimeData: Bool
        let resourceType: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            licencePlate = try values.decode(String.self, forKey: .licencePlate)
            range = try values.decode(Int.self, forKey: .range)
            helmets = try values.decode(Int.self, forKey: .helmets)
            model = try values.decode(String.self, forKey: .model)
            resourceImageId = try values.decode(String.self, forKey: .resourceImageId)
            realTimeData = try values.decode(Bool.self, forKey: .realTimeData)
            resourceType = try values.decode(String.self, forKey: .resourceType)
        }
    }
    
    struct BikeStation: Codable {
        let realTimeData: Bool
        let availableResources: Int
        let spacesAvailable: Int
        let allowDropoff: Bool
        let bikesAvailable: Int
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            realTimeData = try values.decode(Bool.self, forKey: .realTimeData)
            availableResources = try values.decode(Int.self, forKey: .availableResources)
            spacesAvailable = try values.decode(Int.self, forKey: .spacesAvailable)
            allowDropoff = try values.decode(Bool.self, forKey: .allowDropoff)
            bikesAvailable = try values.decode(Int.self, forKey: .bikesAvailable)
        }
    }
}

//{
//    "id":"402:11059006",
//    "name":"Rossio",
//    "x":-9.1424,
//    "y":38.71497,
//    "scheduledArrival":0,
//    "locationType":0,
//    "companyZoneId":402,
//    "lat":38.71497,
//    "lon":-9.1424
//}


//{
//    "id":"378:M28",
//    "name":"ROSSIO",
//    "x":-9.13796,
//    "y":38.71402,
//    "scheduledArrival":0,
//    "locationType":0,
//    "companyZoneId":378,
//    "lat":38.71402,
//    "lon":-9.13796
//}


//{
//    "id":"382:1_1402",
//    "name":"IGREJA DE SÃO SEBASTIÃO",
//    "x":-9.151782,
//    "y":38.731597,
//    "scheduledArrival":0,
//    "locationType":0,
//    "companyZoneId":382,
//    "lat":38.731597,
//    "lon":-9.151782
//}


//{
//    "id":"PT-LIS-A00105",
//    "name":"11VJ44",
//    "x":-9.147266,
//    "y":38.717655,
//    "licencePlate":"11VJ44",
//    "range":23,
//    "batteryLevel":30,
//    "helmets":2,
//    "model":"Askoll",
//    "resourceImageId":"vehicle_gen_ecooltra",
//    "realTimeData":true,
//    "resourceType":"MOPED",
//    "companyZoneId":473
//}


//{
//    "id":"222",
//    "name":"222 - Praça da Figueira",
//    "x":-9.13828,
//    "y":38.71383,
//    "realTimeData":true,
//    "station":true,
//    "availableResources":20,
//    "spacesAvailable":10,
//    "allowDropoff":true,
//    "companyZoneId":412,
//    "bikesAvailable":20
//}
