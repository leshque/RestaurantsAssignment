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
    let viewModelMapper: RestaurantListViewModelMapperProtocol
    
    init(
        interactor: RestaurantListInteractorProtocol,
        viewModelMapper: RestaurantListViewModelMapperProtocol
    ) {
        self.interactor = interactor
        self.viewModelMapper = viewModelMapper
    }
    
    private var workItem: DispatchWorkItem?
    
    lazy var onSearch: (String) -> () = { [weak self] query in
        guard let self = self else { return }
        
        self.workItem?.cancel()
        
        let searchWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.searchRestaurants(
                query: query,
                completion: self.renderRestaurants
            )
        }
        
        self.workItem = searchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem)
    }
    
    func viewDidLoad() {
        view?.render(viewModel: initialViewModel())
        searchRestaurants(query: "", completion: renderRestaurants)
    }
    
    private func renderRestaurants(_ restaurants: Restaurants) {
        print("we've got some restaurants: \(restaurants.restaurants.count)")
        
        view?.render(
            viewModel: self.viewModelMapper.mapRestaurants(
                restaurants,
                actions: getActions()
            )
        )
    }
    
    private func searchRestaurants(
        query: String,
        completion: (Restaurants) -> ()
    ) {
        interactor.loadData (
            searchQuery: query,
            sortBy: \Restaurant.name,
            sortOrder: .ascending
        ) { restaurants in
            completion(restaurants)
        }
    }
    
    private func getActions() -> RestaurantListActions {
        RestaurantListActions(onSearch: onSearch)
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
            actions: getActions(),
            sections: [RestaurantListSectionViewModel(items: [])]
        )
    }
    
    //    func errorViewModel() -> RestaurantListViewModel {
    //        RestaurantListViewModel(actions: RestaurantListViewModel.Actions(onSearch: onSearch), repos: [BasicCellViewModel(title: "Error fetching Repos", onTap: { })])
    //    }
    
}
