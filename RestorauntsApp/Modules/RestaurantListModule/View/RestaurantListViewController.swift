//
// Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

protocol RestaurantListViewProtocol {

    func render(viewModel: RestaurantListViewModel) {

}

class RestaurantListViewController: UIViewController, RestaurantListViewProtocol {

    // MARK: Dependencies

    private let presenter: RestaurantListPresenterProtocol
    private let dataSource: RestaurantListDataSource

    // MARK: UI

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Enter Repo name..."
        return bar
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
        navigationItem.titleView = searchBar
    }

    private func layoutViews() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

    }

    // MARK: RepoListViewProtocol

    func render(viewModel: RestaurantListViewModel) {
        onSearch = viewModel.actions.onSearch
        dataSource.render(
                tableView: tableView,
                cellViewModels: viewModel.repos
        )
    }



}
