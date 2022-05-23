//
//  RestaurantListDomainModelMapper.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 23.05.22.
//

import Foundation

protocol RestaurantListDomainModelMapperProtocol {
    
    func mapRestaurants(codable: RestaurantsCodable) -> Restaurants
    
}

class RestaurantListDomainModelMapper: RestaurantListDomainModelMapperProtocol {
    
    func mapRestaurants(codable: RestaurantsCodable) -> Restaurants {
        Restaurants(
            restaurants: codable.restaurants.map {
                mapRestaurant(codable: $0)
            }
        )
    }
    
    private func mapRestaurant(codable: RestaurantCodable) -> Restaurant {
        Restaurant(
            name: codable.name,
            status: mapStatus(codableStatus: codable.status),
            sortingValues: mapSortingValues(codable: codable.sortingValues)
        )
    }
    
    private func mapSortingValues(codable: SortingValuesCodable) -> Restaurant.SortingValues {
        Restaurant.SortingValues(
            bestMatch: codable.bestMatch,
            newest: codable.newest,
            ratingAverage: codable.ratingAverage,
            distance: codable.distance,
            popularity: codable.popularity,
            averageProductPrice: codable.averageProductPrice,
            deliveryCosts: codable.deliveryCosts,
            minCost: codable.minCost
        )
    }
    
    private func mapStatus(codableStatus: RestaurantCodable.Status) -> Restaurant.Status {
        switch codableStatus {
        case .open:
            return Restaurant.Status.open
        case .closed:
            return Restaurant.Status.closed
        case .orderAhead:
            return Restaurant.Status.orderAhead
        }
    }
    
}
