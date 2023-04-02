//
//  FilmsResponse.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 27.03.2023.
//

import Foundation

struct FilmsResponse: Decodable {
    let title: String?
    let episodeID: Int?
    let openingCrawl: String?
    let director: String?
    let producer: String?
    let releaseDate: String?
    let characters: [String]?
    let planets: [String]?
    let starships: [String]?
    let vehicles: [String]?
    let species: [String]?
    let url: String?
    
    enum FilmResponseCodinKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case planets
        case starships
        case vehicles
        case species
        case url
    }
    
}
