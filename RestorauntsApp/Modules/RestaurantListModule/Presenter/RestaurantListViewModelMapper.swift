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
    
    private lazy var currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumFractionDigits = 1
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.init(identifier: "de_DE")
        return currencyFormatter
    }()
    
    private lazy var measurementFormatter: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.locale = Locale.init(identifier: "de_DE")
        measurementFormatter.numberFormatter.maximumFractionDigits = 1
        return measurementFormatter
    }()
    
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
 
    private func getResaturantValue(from restaurant: Restaurant, for sortOption: RestaurantListSortOption) -> String? {
        switch sortOption {
        case .alphabetic:
            return nil
        case .bestMatch:
            return "Best match: \(restaurant.sortingValues.bestMatch)"
        case .newest:
            return "Newest: \(restaurant.sortingValues.newest)"
        case .ratingAverage:
            return "Average rating: \(restaurant.sortingValues.ratingAverage)"
        case .distanceAscending:
            return "Distance: \(formatDistance(restaurant.sortingValues.distance))"
        case .distanceDescending:
            return "Distance: \(formatDistance(restaurant.sortingValues.distance))"
        case .popularity:
            return "Popularity: \(restaurant.sortingValues.popularity)"
        case .averageProductPrice:
            return "Average Product Price:  \(formatPrice(restaurant.sortingValues.averageProductPrice))"
        case .deliveryCosts:
            return "Delivery Cost:  \(formatPrice(restaurant.sortingValues.deliveryCosts))"
        case .minCost:
            return "Minimal Order: \(formatPrice(restaurant.sortingValues.minCost))"
        }
    }
    
    private func formatPrice(_ price: Restaurant.SortingValues.Price) -> String {
        currencyFormatter.string(from: NSNumber(value: price / 100)) ?? ""
    }
    
    private func formatDistance(_ distance: Restaurant.SortingValues.Distance) -> String {
        let measurement = Measurement(value: Double(distance), unit: UnitLength.meters).converted(to: .kilometers)
        return measurementFormatter.string(from: measurement)
    }
}
