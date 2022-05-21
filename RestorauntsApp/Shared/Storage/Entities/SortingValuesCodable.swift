//
//  SortingValuesCodable.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

struct SortingValuesCodable: Codable {
        
    let bestMatch: Double
    let newest: Double
    let ratingAverage: Double
    let distance: Int
    let popularity: Double
    let averageProductPrice: Int
    let deliveryCosts: Int
    let minCost: Int
    
}
