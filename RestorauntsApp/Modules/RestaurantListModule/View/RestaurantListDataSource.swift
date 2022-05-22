//
// Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

protocol RestaurantListDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {

    func render(tableView: UITableView, sections: [RestaurantListSectionViewModel])

}

class RestaurantListDataSource: NSObject, RestaurantListDataSourceProtocol {

    private var sections: [RestaurantListSectionViewModel] = [RestaurantListSectionViewModel]()
    private var tableView: UITableView?

    func render(tableView: UITableView, sections: [RestaurantListSectionViewModel]) {
        self.sections = sections
        self.tableView = tableView
        tableView.register(RestaurauntListTableCellView.self, forCellReuseIdentifier: RestaurauntListTableCellView.reuseIdentifier)
        tableView.dataSource = self
        tableView.reloadData()

    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurauntListTableCellView.reuseIdentifier) as? RestaurauntListTableCellView else {
            return UITableViewCell()
        }
        cell.render(sections[indexPath.section].items[indexPath.row]) 
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewModel = sections[indexPath.section].items[indexPath.row]
        //viewModel.onTap
    }

}
