//
//  EndpointType.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 27.03.2023.
//

import Foundation

enum EndpointType: Equatable {
    case people
    case peopleDetail(url: String)
    case planets
    case planetsDetail(url: String)
    case films
    case filmsDetail(url: String)
    case species
    case speciesDeitail(url: String)
    case vehicles
    case vehiclesDetail(url: String)
    case starships
    case starshipsDetail(url: String)
    
    private static let baseURL = "https://swapi.dev/api/"
    
    var endpointValue: String {
        switch self {
        case .people:
            return EndpointType.baseURL + "people/"
        case .peopleDetail(let url):
            return url
        case .planets:
            return EndpointType.baseURL + "planets/"
        case .planetsDetail(let url):
            return url
        case .films:
            return EndpointType.baseURL + "films/"
        case .filmsDetail(let url):
            return url
        case .species:
            return EndpointType.baseURL + "species/"
        case .speciesDeitail(let url):
            return url
        case .vehicles:
            return EndpointType.baseURL + "vehicles/"
        case .vehiclesDetail(let url):
            return url
        case .starships:
            return EndpointType.baseURL + "starships/"
        case .starshipsDetail(let url):
            return url
        }
    }
}
