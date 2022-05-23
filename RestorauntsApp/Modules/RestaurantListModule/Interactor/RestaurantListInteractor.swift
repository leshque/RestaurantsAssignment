//
//  RestaurantListInteractor.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

protocol RestaurantListInteractorProtocol {
    
    func loadData(
        searchQuery: String,
        sortSettings: SortSettings,
        completion: (Restaurants) -> Void
    )
    
    func saveSortOption(_ option: RestaurantListSortOption)
    func getSortOption() -> RestaurantListSortOption
    
}

class RestaurantListInteractor: RestaurantListInteractorProtocol {
    
    let storageClient: StorageClientProtocol
    let settingsProvider: SettingsProviderProtocol
    
    init(
        storageClient: StorageClientProtocol,
        settingsProvider: SettingsProviderProtocol
    ) {
        self.storageClient = storageClient
        self.settingsProvider = settingsProvider
    }
    
    func loadData(
        searchQuery: String,
        sortSettings: SortSettings,
        completion: (Restaurants) -> Void
    ) {
        let restaurantsCodable = storageClient.getRestaurants()
        let restaurantsDTO = mapRestaurants(
            codable: restaurantsCodable
        )
        let restaurantsFiltered = restaurantsDTO.restaurants.filter {
            searchQuery == "" ? true : $0.name.localizedCaseInsensitiveContains(searchQuery)
        }.sorted(
            using: [
                SortConfig(
                    descriptor: .keyPath(\Restaurant.status),
                    order: .ascending
                ),
                SortConfig(
                    descriptor: .keyPath(sortSettings.sortBy),
                    order: sortSettings.sortOrder
                ),
                SortConfig(
                    descriptor: .keyPath(\Restaurant.name),
                    order: .ascending
                )
            ]
        )
        completion(Restaurants(restaurants: restaurantsFiltered))
    }
    
    func saveSortOption(_ option: RestaurantListSortOption) {
        settingsProvider.setCurrentSortingOption(option)
    }
    
    func getSortOption() -> RestaurantListSortOption {
        settingsProvider.getCurrentSortingOption()
    }

}

extension RestaurantListInteractor {
    
    // Codable -> DTO mapping
    
    private func mapRestaurants(codable: RestaurantsCodable) -> Restaurants {
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
