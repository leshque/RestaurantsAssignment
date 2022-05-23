//
//  MockRestaurantListInteractor.swift
//  RestorauntsAppTests
//
//  Created by Aliaksei Prokharau on 23.05.22.
//

import Foundation
@testable import RestorauntsApp

class MockRestaurantListInteractor: RestaurantListInteractorProtocol {
    
    var mockLoadData: (String, SortSettings, (Restaurants) -> Void) -> Void = { _, _, _ in }
    
    var mockSaveSortOption: (RestaurantListSortOption) -> Void = { _ in }
    
    var mockGetSortOption: () -> RestaurantListSortOption = { RestaurantListSortOption.bestMatch }
    
    func loadData(searchQuery: String, sortSettings: SortSettings, completion: (Restaurants) -> Void) {
        mockLoadData(searchQuery, sortSettings, completion)
    }
    
    func saveSortOption(_ option: RestaurantListSortOption) {
        mockSaveSortOption(option)
    }
    
    func getSortOption() -> RestaurantListSortOption {
        mockGetSortOption()
    }
    
}
