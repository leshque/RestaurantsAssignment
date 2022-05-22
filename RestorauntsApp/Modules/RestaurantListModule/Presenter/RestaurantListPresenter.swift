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
    private var lastSearchQuery: String = ""
    private var sortOption: RestaurantListSortOption = .bestMatch
    
    lazy var onSearch: (String) -> () = { [weak self] query in
        guard let self = self else { return }
        
        self.workItem?.cancel()
        self.lastSearchQuery = query
        let searchWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.searchRestaurants(
                query: query,
                sortOption: self.sortOption,
                completion: self.renderRestaurants
            )
        }
        
        self.workItem = searchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem)
    }
    
    lazy var onSortSelectTapped: () -> Void = { [weak self] in
        guard let self = self else { return }
        self.view?.presentSortSelector(
            selectedOption: self.getCurrentSortOption(),
            options: RestaurantListSortOption.allCases,
            onSelect: { [weak self] sortOption in
                guard let self = self else { return }
                self.searchRestaurants(
                    query: "",
                    sortOption: sortOption,
                    completion: self.renderRestaurants
                )
            }
        )
    }
    
    private func getCurrentSortOption() -> RestaurantListSortOption {
        .bestMatch
    }
    
    
    func viewDidLoad() {
        view?.render(viewModel: initialViewModel())
        searchRestaurants(
            query: "",
            sortOption: sortOption,
            completion: renderRestaurants
        )
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
        sortOption: RestaurantListSortOption,
        completion: (Restaurants) -> ()
    ) {
        interactor.loadData (
            searchQuery: query,
            sortSettings: SortSettings(sortBy: (\.name), sortOrder: .ascending)
        ) { restaurants in
            completion(restaurants)
        }
    }
    
    private func getActions() -> RestaurantListActions {
        RestaurantListActions(
            onSearch: onSearch,
            onSortSelectTapped: onSortSelectTapped
        )
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
            sections: [RestaurantListSectionViewModel(items: [])],
            footerViewModel: RestaurantListFooterViewModel(
                buttonTitle: "Sorted by: \(sortOption.title)",
                actions: RestaurantListFooterViewModel.Actions(onSortSelectTapped: onSortSelectTapped)
            )
        )
    }
    
}

extension RestaurantListPresenter {
    
//    private func mapSortOption(_ option: RestaurantListSortOption) -> SortSettings<T: Comparable> {
//        switch option {
//        case .alphabetic:
//            return SortSettings(sortBy: (\.name), sortOrder: .ascending)
//        case .bestMatch:
//            return SortSettings(sortBy: (\.sortingValues.bestMatch), sortOrder: .descending)
//        case .newest:
//            return SortSettings(sortBy: (\.sortingValues.newest), sortOrder: .descending)
//        case .ratingAverage:
//            return SortSettings(sortBy: (\.sortingValues.ratingAverage), sortOrder: .descending)
//        case .distanceAscending:
//            return SortSettings(sortBy: (\.sortingValues.distance), sortOrder: .ascending)
//        case .distanceDescending:
//            return SortSettings(sortBy: (\.sortingValues.distance), sortOrder: .descending)
//        case .popularity:
//            return SortSettings(sortBy: (\.sortingValues.popularity), sortOrder: .descending)
//        case .averageProductPrice:
//            return SortSettings(sortBy: (\.sortingValues.averageProductPrice), sortOrder: .descending)
//        case .deliveryCosts:
//            return SortSettings(sortBy: (\.sortingValues.deliveryCosts), sortOrder: .descending)
//        case .minCost:
//            return SortSettings(sortBy: (\.sortingValues.minCost), sortOrder: .ascending)
//        }
//    }
    
}
