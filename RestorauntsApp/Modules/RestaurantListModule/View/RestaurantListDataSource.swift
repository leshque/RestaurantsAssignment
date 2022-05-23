//
// Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

protocol RestaurantListDataSourceProtocol {

    func render(tableView: UITableView, sections: [RestaurantListSectionViewModel])

}

class RestaurantListDataSource: NSObject, RestaurantListDataSourceProtocol {

    private var sections: [RestaurantListSectionViewModel] = [RestaurantListSectionViewModel]()
    private var tableView: UITableView?
    private var dataSource:  UITableViewDiffableDataSource<Section, RestaurantListCellViewModel>?
    
    func render(tableView: UITableView, sections: [RestaurantListSectionViewModel]) {
        self.sections = sections
        self.tableView = tableView
        tableView.register(RestaurantListTableCellView.self, forCellReuseIdentifier: RestaurantListTableCellView.reuseIdentifier)
        if (dataSource == nil) {
            dataSource = makeDataSource(tableView: tableView)
            tableView.dataSource = dataSource
        }
        update(with: sections, animate: true)
    }

}

extension RestaurantListDataSource {

    enum Section: Hashable {
        case firstSection
    }
    
    func makeDataSource(tableView: UITableView) -> UITableViewDiffableDataSource<Section, RestaurantListCellViewModel> {
        let dataSource = UITableViewDiffableDataSource<Section, RestaurantListCellViewModel>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, cellViewModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListTableCellView.reuseIdentifier) as? RestaurantListTableCellView else {
                    return UITableViewCell()
                }
                cell.render(cellViewModel)
                return cell
            }
        )
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }
    
    func update(with sections: [RestaurantListSectionViewModel], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RestaurantListCellViewModel>()
        snapshot.appendSections([.firstSection])
        if !sections.isEmpty {
            snapshot.appendItems(sections[0].items, toSection: .firstSection)
        }
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
}
