//
//  RestaurantCodable.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

struct RestaurantCodable: Codable {
    
    let name: String
    let status: Status
    let sortingValues: SortingValuesCodable
    
}

extension RestaurantCodable {
    
    enum Status: String, Codable {

        case open
        case orderAhead = "order ahead"
        case closed
        
        enum CodingKeys: String, CodingKey {
            case open
            case orderAhead
            case closed
        }
        
    }
    
}
