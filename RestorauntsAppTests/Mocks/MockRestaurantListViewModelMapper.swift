//
//  MockRestaurantListViewModelMapper.swift
//  RestorauntsAppTests
//
//  Created by Aliaksei Prokharau on 23.05.22.
//

import Foundation
@testable import RestorauntsApp

class MockRestaurantListViewModelMapper: RestaurantListViewModelMapperProtocol {
    
    var mockMapRestaurants: (
        Restaurants,
        RestaurantListActions,
        RestaurantListSortOption
    ) -> RestaurantListViewModel = { _, _, _ in
        RestaurantListViewModel(
            actions: RestaurantListActions(
                onSearch: { _ in },
                onSortSelectTapped: { }
            ),
            sections: [],
            footerViewModel: RestaurantListFooterViewModel(
                buttonTitle: "",
                actions: RestaurantListFooterViewModel.Actions(onSortSelectTapped: { })
            )
        )
    }
    
    func mapRestaurants(
        _ restaurants: Restaurants,
        actions: RestaurantListActions,
        sortOption: RestaurantListSortOption
    ) -> RestaurantListViewModel {
        mockMapRestaurants(restaurants, actions, sortOption)
    }
    
}
