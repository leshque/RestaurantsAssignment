//
//  SortingDescriptor.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

enum SortOrder {
    
    case ascending
    case descending
    
}

struct SortDescriptor<Value> {
    
    var comparator: (Value, Value) -> ComparisonResult
    
}

struct SortConfig<Value> {
    
    let descriptor: SortDescriptor<Value>
    let order: SortOrder
    
}

extension SortDescriptor {
    
    static func keyPath<T: Comparable>(
        _ keyPath: KeyPath<Value, T>
    ) -> Self {
        Self { rootA, rootB in
            let valueA = rootA[keyPath: keyPath]
            let valueB = rootB[keyPath: keyPath]

            guard valueA != valueB else {
                return .orderedSame
            }

            return valueA < valueB ? .orderedAscending : .orderedDescending
        }
    }
    
}
