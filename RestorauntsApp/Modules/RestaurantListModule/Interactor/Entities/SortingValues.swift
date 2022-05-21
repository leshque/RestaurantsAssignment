//
//  SortingValues.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

extension Restaurant {
    
    struct SortingValues: Codable {
        
        typealias Price = Int
        typealias Distance = Int
        
        let bestMatch: Double
        let newest: Double
        let ratingAverage: Double
        let distance: Distance
        let popularity: Double
        let averageProductPrice: Price
        let deliveryCosts: Price
        let minCost: Price
        
    }
    
}
