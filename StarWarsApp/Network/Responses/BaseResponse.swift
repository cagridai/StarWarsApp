//
//  BaseResponse.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 27.03.2023.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: T?
}
