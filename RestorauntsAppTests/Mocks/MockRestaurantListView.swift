//
//  MockRestaurantListView.swift
//  RestorauntsAppTests
//
//  Created by Aliaksei Prokharau on 23.05.22.
//

import Foundation
@testable import RestorauntsApp

class MockRestaurantListView: RestaurantListViewProtocol {
    
    var mockRender: (RestaurantListViewModel) -> Void = { _ in }
    
    var mockPresentSortSelector: (
        RestaurantListSortOption,
        [RestaurantListSortOption],
        (RestaurantListSortOption) -> Void
    ) -> Void = { _, _, _ in }
    
    func render(viewModel: RestaurantListViewModel) {
        mockRender(viewModel)
    }
    
    func presentSortSelector(
        selectedOption: RestaurantListSortOption,
        options: [RestaurantListSortOption],
        onSelect: @escaping (RestaurantListSortOption) -> Void
    ) {
        mockPresentSortSelector(selectedOption, options, onSelect)
    }
    
}
