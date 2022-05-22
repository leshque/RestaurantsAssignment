//
//  SortSettings.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

struct SortSettings<T: Comparable> {
    
    let sortBy: KeyPath<Restaurant, T>
    let sortOrder: SortOrder
    
}
