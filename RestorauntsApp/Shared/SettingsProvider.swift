//
//  SettingsProvider.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 23.05.22.
//

import Foundation

protocol SettingsProviderProtocol {
    
    func setCurrentSortingOption(_ option: RestaurantListSortOption)
    func getCurrentSortingOption() -> RestaurantListSortOption
    
}

class UserDefaultsSettingsProvider: SettingsProviderProtocol {
    
    private struct Constants {
        
        static let sortOptionKey = "sortOptionKey"
        
    }
    
    func setCurrentSortingOption(_ option: RestaurantListSortOption) {
        let defaults = UserDefaults.standard
        defaults.set(option.rawValue, forKey: Constants.sortOptionKey)
    }
    
    func getCurrentSortingOption() -> RestaurantListSortOption {
        let defaults = UserDefaults.standard
        if let value = defaults.object(forKey: Constants.sortOptionKey) as? String,
           let option = RestaurantListSortOption.init(rawValue: value) {
            return option
        } else {
            return RestaurantListSortOption.default
        }
    }
    
}
