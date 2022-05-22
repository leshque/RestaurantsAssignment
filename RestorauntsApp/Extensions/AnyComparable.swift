//
//  AnyComparable.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation

struct AnyComparable: Equatable, Comparable {
    private let lessThan: (Any) -> Bool
    private let value: Any
    private let equals: (Any) -> Bool

    public static func == (lhs: AnyComparable, rhs: AnyComparable) -> Bool {
        lhs.equals(rhs.value) || rhs.equals(lhs.value)
    }
    
    public init<C: Comparable>(_ value: C) {
        self.value = value
        self.equals = { $0 as? C == value }
        self.lessThan = { ($0 as? C).map { value < $0 } ?? false }
    }

    public static func < (lhs: AnyComparable, rhs: AnyComparable) -> Bool {
        lhs.lessThan(rhs.value) || (rhs != lhs && !rhs.lessThan(lhs.value))
    }
}

extension Comparable {
    
    var anyComparable: AnyComparable {
        .init(self)
    }
    
}
