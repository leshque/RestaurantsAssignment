//
//  RestaurantListFooterViewModel.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

struct RestaurantListFooterViewModel {
    
    struct Actions {
        
        let onSortSelectTapped: () -> Void
        
    }
    
    let buttonTitle: String
    let actions: Actions
    
}
