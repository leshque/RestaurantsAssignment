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
    let domainModelMapper: RestaurantListDomainModelMapperProtocol
    
    init(
        storageClient: StorageClientProtocol,
        settingsProvider: SettingsProviderProtocol,
        domainModelMapper: RestaurantListDomainModelMapperProtocol
    ) {
        self.storageClient = storageClient
        self.settingsProvider = settingsProvider
        self.domainModelMapper = domainModelMapper
    }
    
    func loadData(
        searchQuery: String,
        sortSettings: SortSettings,
        completion: (Restaurants) -> Void
    ) {
        let restaurantsCodable = storageClient.getRestaurants()
        let restaurantsDTO = domainModelMapper.mapRestaurants(
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
