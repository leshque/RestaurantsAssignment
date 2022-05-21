
//
//  RestaurantListModule.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation
import UIKit

protocol RestaurantListModuleProtocol {    

    func getView() -> UIViewController

}

class RestaurantListModule: RestaurantListModuleProtocol {
    
    func getView() -> UIViewController {
        let vc = RestaurantListViewController()
        return vc
    }

    func getView() -> UINavigationController {
        let presenter = presenter()
        let repoVC = RestaurantListViewProtocol(
                presenter: presenter,
                dataSource: RestaurantListDataSource()
        )
        presenter.view = repoVC
        let navController = UINavigationController(rootViewController: repoVC)
        return navController
    }

    func presenter() -> RepoListPresenter {
        RepoListPresenter(interactor: interactor())
    }

    func interactor() -> RepoListInteractorProtocol {
        RepoListInteractor(networkClient: AppEnvironment.shared.networkClient)
    }
    
}


