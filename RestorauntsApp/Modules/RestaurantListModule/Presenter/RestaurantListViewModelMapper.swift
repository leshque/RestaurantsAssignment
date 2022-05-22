//
//  RestaurantListViewModelMapper.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

protocol RestaurantListViewModelMapperProtocol {
    
    func mapRestaurants(
        _ restaurants: Restaurants,
        actions: RestaurantListActions,
        sortOption: RestaurantListSortOption
    ) -> RestaurantListViewModel
    
}

class RestaurantListViewModelMapper: RestaurantListViewModelMapperProtocol {
    
    func mapRestaurants(
        _ restaurants: Restaurants,
        actions: RestaurantListActions,
        sortOption: RestaurantListSortOption
    ) -> RestaurantListViewModel {
        RestaurantListViewModel(
            actions: actions,
            sections: [
                RestaurantListSectionViewModel(
                    items: restaurants.restaurants.map {
                        self.mapRestaurant($0, sortOption: sortOption)
                    }
                )
            ],
            footerViewModel: mapFooterViewModel(
                actions: actions,
                sortOption: sortOption
            )
        )
    }
    
    private func mapFooterViewModel(
        actions: RestaurantListActions,
        sortOption: RestaurantListSortOption
    ) -> RestaurantListFooterViewModel {
        RestaurantListFooterViewModel(
            buttonTitle: "Sorted by: \(sortOption.title)",
            actions: RestaurantListFooterViewModel.Actions(onSortSelectTapped: actions.onSortSelectTapped)
        )
    }
 
    private func mapRestaurant(
        _ restaurant: Restaurant,
        sortOption: RestaurantListSortOption
    ) -> RestaurantListCellViewModel {
        RestaurantListCellViewModel(
            name: restaurant.name,
            status: mapStatus(restaurant.status),
            sortValue: getResaturantValue(
                from: restaurant,
                for: sortOption
            )
        )
    }
    
    private func mapStatus(_ status: Restaurant.Status) -> RestaurantListCellViewModel.Status {
        switch status {
        case .open:
            return .open
        case .orderAhead:
            return .orderAhead
        case .closed:
            return .closed
        }
    }
 
    private func getResaturantValue(from restaurant: Restaurant, for sortOption: RestaurantListSortOption) -> String {
        switch sortOption {
        case .alphabetic:
            return restaurant.name
        case .bestMatch:
            return "\(restaurant.sortingValues.bestMatch)"
        case .newest:
            return "\(restaurant.sortingValues.newest)"
        case .ratingAverage:
            return "\(restaurant.sortingValues.ratingAverage)"
        case .distanceAscending:
            return "\(restaurant.sortingValues.distance)"
        case .distanceDescending:
            return "\(restaurant.sortingValues.distance)"
        case .popularity:
            return "\(restaurant.sortingValues.popularity)"
        case .averageProductPrice:
            return "\(restaurant.sortingValues.averageProductPrice)"
        case .deliveryCosts:
            return "\(restaurant.sortingValues.deliveryCosts)"
        case .minCost:
            return "\(restaurant.sortingValues.minCost)"
        }
    }
}
