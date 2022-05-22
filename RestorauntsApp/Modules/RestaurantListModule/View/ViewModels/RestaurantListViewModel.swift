//
// Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

struct RestaurantListViewModel {

    let actions: RestaurantListActions
    let sections: [RestaurantListSectionViewModel]

}

struct RestaurantListActions {

    let onSearch: (String) -> ()

}
