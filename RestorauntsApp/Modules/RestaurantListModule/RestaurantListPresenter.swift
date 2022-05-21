//
// Created by Aliaksei Prokharau on 21.05.22.
//

import Foundation

protocol RestaurantListPresenterProtocol {

    func viewDidLoad()
    
}

class RestaurantListPresenter: RestaurantListPresenterProtocol {

    weak var view: RestaurantListViewProtocol?
    let interactor: RestaurantListInteractorProtocol
    
    init(
        interactor: RestaurantListInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    private var workItem: DispatchWorkItem?
    
    lazy var onSearch: (String) -> () = { [weak self] query in
        guard let self = self else { return }
        
//        self.workItem?.cancel()
//
//        let searchWorkItem = DispatchWorkItem {
//            self.searchRepos(query: query) { result in
//                switch result {
//                case .success(let repositoriesDTO):
//                    self.view?.render(viewModel: self.viewModel(from: repositoriesDTO))
//                case .failure(_):
//                    self.view?.render(viewModel: self.initialViewModel())
//                }
//            }
//        }
//
//        self.workItem = searchWorkItem
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem)
    }
    
    func viewDidLoad() {
        view?.render(viewModel: initialViewModel())
        interactor.loadData { restaurants in
            print("we've got some restaurants: \(restaurants.restaurants.count)")
        }
    }
    
//    private func searchRepos(
//        query: String,
//        completion: (Result<RepositoriesDTO, Error>) -> ()
//    ) {
//        interactor.loadRepos(query: query) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let repsDTO):
//                let viewModel = self.viewModel(from: repsDTO)
//                self.view?.render(viewModel: viewModel)
//            case .failure(_):
//                let viewModel = self.errorViewModel()
//                self.view?.render(viewModel: viewModel)
//            }
//        }
//    }
     
}

extension RestaurantListPresenter {
    
    func initialViewModel() -> RestaurantListViewModel {
        RestaurantListViewModel(
            actions: RestaurantListViewModel.Actions(onSearch: onSearch),
            sections: [RestaurantListSectionViewModel(items: [])]
        )
    }
    
//    func errorViewModel() -> RestaurantListViewModel {
//        RestaurantListViewModel(actions: RestaurantListViewModel.Actions(onSearch: onSearch), repos: [BasicCellViewModel(title: "Error fetching Repos", onTap: { })])
//    }
    
}
