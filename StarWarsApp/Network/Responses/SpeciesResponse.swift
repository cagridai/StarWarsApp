//
//  SpeciesResponse.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 27.03.2023.
//

import Foundation

struct SpeciesResponse: Decodable {
    let name: String?
    let classification: String?
    let designation: String?
    let averageHeight: String?
    let skinColors: String?
    let hairColors: String?
    let eyeColors: String?
    let averageLifespan: String?
    let homeworld: String?
    let language: String?
    let people: [String]?
    let films: [String]?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case classification
        case designation
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeworld
        case language
        case people
        case films
        case url
    }
}
