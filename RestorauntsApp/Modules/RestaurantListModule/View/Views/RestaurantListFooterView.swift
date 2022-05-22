//
//  RestaurantListFooterView.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation
import UIKit

protocol RestaurantListFooterViewProtocol: UIView {
    
    func render(_ viewModel: RestaurantListFooterViewModel)
    
}

class RestaurantListFooterView: UIView, RestaurantListFooterViewProtocol {
    
    private var onSortSelectTapped: () -> Void = { }
    private var viewModel: RestaurantListFooterViewModel?
    
    private lazy var sortByButton: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(sortByTapped),
            for: .primaryActionTriggered
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    static func instantiate() -> RestaurantListFooterView {
        let view = RestaurantListFooterView()
        view.setupView()
        view.layoutViews()
        return view
    }
    
    private func setupView() {
        addSubview(sortByButton)
        backgroundColor = .white
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            sortByButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            sortByButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            sortByButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            sortByButton.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    @objc private func sortByTapped() {
        onSortSelectTapped()
    }
    
    func render(_ viewModel: RestaurantListFooterViewModel) {
        onSortSelectTapped = viewModel.actions.onSortSelectTapped
        sortByButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    
    
}
