//
//  Restaurant.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

struct Restaurant {
    
    let name: String
    let status: Status
    let sortingValues: SortingValues
    
}

extension Restaurant {
    
    enum Status: Comparable {

        case open
        case orderAhead
        case closed
            
    }
    
}
