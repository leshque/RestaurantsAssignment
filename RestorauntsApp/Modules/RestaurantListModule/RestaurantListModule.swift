
//
//  RestaurantListModule.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation
import UIKit

protocol RestaurantListModuleProtocol {    

    func getView() -> UINavigationController

}

class RestaurantListModule: RestaurantListModuleProtocol {
    
    func getView() -> UINavigationController {
        let presenter = presenter()
        let repoVC = RestaurantListViewController(
                presenter: presenter,
                dataSource: RestaurantListDataSource()
        )
        presenter.view = repoVC
        let navController = UINavigationController(rootViewController: repoVC)
        return navController
    }

    func presenter() -> RestaurantListPresenter {
        RestaurantListPresenter(
            interactor: interactor(),
            viewModelMapper: RestaurantListViewModelMapper()
        )
    }

    func interactor() -> RestaurantListInteractorProtocol {
        RestaurantListInteractor(
            storageClient: AppEnvironment.shared.storageClient,
            settingsProvider: AppEnvironment.shared.settingsProvider,
            domainModelMapper: RestaurantListDomainModelMapper()
        )
    }
    
}
