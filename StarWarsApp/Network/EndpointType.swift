//
//  EndpointType.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 27.03.2023.
//

import Foundation

enum EndpointType {
    case people
    case planets
    case films
    case species
    case vehicles
    case starships
    
    private static let baseURL = "https://swapi.dev/api/"
    
    var endpointValue: String {
        switch self {
        case .people:
            return EndpointType.baseURL + "people/"
        case .planets:
            return EndpointType.baseURL + "planets/"
        case .films:
            return EndpointType.baseURL + "films/"
        case .species:
            return EndpointType.baseURL + "species/"
        case .vehicles:
            return EndpointType.baseURL + "vehicles/"
        case .starships:
            return EndpointType.baseURL + "starships/"
        }
    }
}
