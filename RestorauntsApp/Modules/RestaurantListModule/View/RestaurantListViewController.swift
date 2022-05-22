//
// Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

protocol RestaurantListViewProtocol: AnyObject {
    
    func render(viewModel: RestaurantListViewModel)
    func presentSortSelector(
        selectedOption: RestaurantListSortOption,
        options: [RestaurantListSortOption],
        onSelect: @escaping (RestaurantListSortOption) -> Void
    )
    
}

class RestaurantListViewController: UIViewController, RestaurantListViewProtocol {
    
    // MARK: Dependencies
    
    private let presenter: RestaurantListPresenterProtocol
    private let dataSource: RestaurantListDataSourceProtocol
    
    // MARK: UI
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Enter Restaurant name..."
        return bar
    }()
    
    lazy var footerView: RestaurantListFooterViewProtocol = {
        let footerView = RestaurantListFooterView.instantiate()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    // MARK: Private Properties
    
    var onSearch: (String) -> () = { _ in }
    
    // MARK: ViewController Lifecycle
    
    init(presenter: RestaurantListPresenter,
         dataSource: RestaurantListDataSourceProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
        layoutViews()
        presenter.viewDidLoad()
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        searchBar.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(footerView)
        navigationItem.titleView = searchBar
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: RestaurantListViewProtocol
    
    func render(viewModel: RestaurantListViewModel) {
        onSearch = viewModel.actions.onSearch
        footerView.render(viewModel.footerViewModel)
        dataSource.render(
            tableView: tableView,
            sections: viewModel.sections
        )
    }
    
    func presentSortSelector(
        selectedOption: RestaurantListSortOption,
        options: [RestaurantListSortOption],
        onSelect: @escaping (RestaurantListSortOption) -> Void
    ) {
        let alertController = UIAlertController(
            title: "Sort by",
            message: "",
            preferredStyle: .actionSheet
        )
        
        for sortOption in options {
            let action  = UIAlertAction(
                title: sortOption.title,
                style: .default
            ) { _ in
                onSelect(sortOption)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .default
        )
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension RestaurantListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onSearch(searchText)
    }
    
}

