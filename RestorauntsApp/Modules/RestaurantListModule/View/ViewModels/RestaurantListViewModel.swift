//
// Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

struct RestaurantListViewModel {

    struct Actions {

        let onSearch: (String) -> ()

    }

    let actions: Actions
    let sections: [RestaurantListSectionViewModel]

}
