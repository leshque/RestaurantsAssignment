//
//  Sequence+Sorting.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

// I've used the sorting approach suggested in this article: https://www.swiftbysundell.com/articles/sorting-swift-collections/

import Foundation

extension Sequence {
    
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>
    ) -> [Element] {
        sorted { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
    
}

extension Sequence {
    
    func sorted(
        using descriptors: [SortDescriptor<Element>],
        order: SortOrder
    ) -> [Element] {
        sorted { valueA, valueB in
            for descriptor in descriptors {
                let result = descriptor.comparator(valueA, valueB)
                switch result {
                case .orderedSame:
                    break
                case .orderedAscending:
                    return order == .ascending
                case .orderedDescending:
                    return order == .descending
                }
            }
            return false
        }
    }
    
    func sorted(
        using sortConfigs: [SortConfig<Element>]
    ) -> [Element] {
        sorted { valueA, valueB in
            for config in sortConfigs {
                let result = config.descriptor.comparator(valueA, valueB)
                switch result {
                case .orderedSame:
                    break
                case .orderedAscending:
                    return config.order == .ascending
                case .orderedDescending:
                    return config.order == .descending
                }
            }
            return false
        }
    }
    
}

extension Sequence {
    
    func sorted(
        using descriptors: SortDescriptor<Element>...
    ) -> [Element] {
        sorted(using: descriptors, order: .ascending)
    }
    
}
