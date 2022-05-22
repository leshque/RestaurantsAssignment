//
//  SortSettings.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

struct SortSettings {
    
    let sortBy: KeyPath<Restaurant, AnyComparable>
    let sortOrder: SortOrder
    
}
