//
// Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

struct RestaurantListCellViewModel {
    
    enum Status {
        case open
        case orderAhead
        case closed
    }
    
    let name: String
    let status: Status
    let sortValue: String
    
}
