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
        actions: RestaurantListActions
    ) -> RestaurantListViewModel
    
}

class RestaurantListViewModelMapper: RestaurantListViewModelMapperProtocol {
    
    func mapRestaurants(
        _ restaurants: Restaurants,
        actions: RestaurantListActions
    ) -> RestaurantListViewModel {
        RestaurantListViewModel(
            actions: actions,
            sections: [
                RestaurantListSectionViewModel(
                    items: restaurants.restaurants.map {
                        self.mapRestaurant($0)
                    }
                )
            ],
            footerViewModel: mapFooterViewModel(actions: actions)            
        )
    }
    
    private func mapFooterViewModel(actions: RestaurantListActions) -> RestaurantListFooterViewModel {
        RestaurantListFooterViewModel(
            buttonTitle: "Sorted by: !231231213212",
            actions: RestaurantListFooterViewModel.Actions(onSortSelectTapped: actions.onSortSelectTapped)
        )
    }
 
    func mapRestaurant(_ restaurant: Restaurant) -> RestaurantListCellViewModel {
        RestaurantListCellViewModel(
            name: restaurant.name,
            status: mapStatus(restaurant.status),
            sortTitle: "Sort title?",
            sortValue: "Sort value?")
    }
    
    func mapStatus(_ status: Restaurant.Status) -> RestaurantListCellViewModel.Status {
        switch status {
        case .open:
            return .open
        case .orderAhead:
            return .orderAhead
        case .closed:
            return .closed
        }
    }
    
}
