//
//  RestaurantListSortOption.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

enum RestaurantListSortOption: String, CaseIterable, Equatable {
    
    case alphabetic
    case bestMatch
    case newest
    case ratingAverage
    case distanceAscending
    case distanceDescending
    case popularity
    case averageProductPrice
    case deliveryCosts
    case minCost
    
    var title: String {
        switch self {
        case .alphabetic:
            return "Alphabetic"
        case .bestMatch:
            return "Best Match"
        case .newest:
            return "Newest"
        case .ratingAverage:
            return "Average Rating"
        case .distanceAscending:
            return "Distance Ascending"
        case .distanceDescending:
            return "Distance Descending"
        case .popularity:
            return "Popularity"
        case .averageProductPrice:
            return "Average Product Price"
        case .deliveryCosts:
            return "Delivery Cost"
        case .minCost:
            return "Minimum Order Cost"
        }
    }

}
