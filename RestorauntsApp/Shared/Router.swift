//
// Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

protocol RouterProtocol {

    func getRestaurantListView() -> UIViewController

}

class Router: RouterProtocol {

    static let shared = Router()

    func getRestaurantListView() -> UIViewController {
        let module = RestaurantListModule()
        return module.getView()
    }

}
