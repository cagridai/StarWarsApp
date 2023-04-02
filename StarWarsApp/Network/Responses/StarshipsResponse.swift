//
//  StarshipsResponse.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 27.03.2023.
//

import Foundation

struct StarshipsResponse: Decodable {
    let name: String?
    let model: String?
    let manufacturer: String?
    let costInCredits: String
    let length: String?
    let maxAtmospheringSpeed: String?
    let crew: String?
    let passengers: String?
    let cargoCapacity: String?
    let consumables: String?
    let hyoerdriveRating: String?
    let MGLT: String?
    let starshipClass: String?
    let pilots: [String]?
    let films: [String]?
    let url: String?
    
    enum StarshipsResponseCodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case costInCredit = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyoerdriveRating = "hyperdrive_rating"
        case MGLT
        case starshipClass = "starship_class"
        case pilots
        case films
        case url
    }
}
