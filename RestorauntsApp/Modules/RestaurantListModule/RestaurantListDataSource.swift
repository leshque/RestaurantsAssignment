//
// Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

protocol RestaurantListDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {

    func render(tableView: UITableView, sections: [RestaurantListSectionViewModel])

}

class RestaurantListDataSource: RestaurantListDataSourceProtocol {

    private var sections: [RestaurantListSectionViewModel] = [RestaurantListSectionViewModel]()
    private var tableView: UITableView?

    func render(tableView: UITableView, sections: [RestaurantListSectionViewModel]) {
        self.sections = sections
        self.tableView = tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.dataSource = self
        tableView.reloadData()

    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = sections[indexPath.section].items[indexPath.row]
        //viewModel.onTap
    }

}
