//
//  RestaurauntListTableCellView.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 22.05.22.
//

import Foundation
import UIKit

class RestaurantListTableCellView: UITableViewCell {
    
    static let reuseIdentifier = "RestaurauntListTableCellView"
    
    struct Constants {
        
        static let spacing: CGFloat = 10
        
    }
    
    // MARK: Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
        
    private lazy var sortValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Constants.spacing,
            leading: Constants.spacing,
            bottom: Constants.spacing,
            trailing: Constants.spacing
        )
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        backgroundColor = .white
        selectionStyle = .none
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(sortValueLabel)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    // MARK: Public Methods
    
    func render(_ viewModel: RestaurantListCellViewModel) {
        titleLabel.text = viewModel.name
        sortValueLabel.text = viewModel.sortValue
        sortValueLabel.isHidden = viewModel.sortValue == nil 
        switch viewModel.status {
        case .open:
            statusLabel.text = "Open"
            statusLabel.textColor = .init(red: 0, green: 100/255, blue: 0, alpha: 1)
        case .orderAhead:
            statusLabel.text = "Order Ahead"
            statusLabel.textColor = .orange
        case .closed:
            statusLabel.text = "Closed"
            statusLabel.textColor = .red
        }
    }
    
}
