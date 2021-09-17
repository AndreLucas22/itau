//
//  javaRepoPopView.swift
//  itau
//
//  Created by André Lucas on 12/09/21.
//

import Foundation
import UIKit

final class JavaRepoPopView: UIView {
    
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        table.estimatedRowHeight = 400
        return table
    }()

    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        setupTableView(delegate: delegate, dataSource: dataSource)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(JavaRepoPopListCell.self, forCellReuseIdentifier: String(describing: JavaRepoPopListCell.self))
    }
}

// MARK: - View Configurate Moethods
extension JavaRepoPopView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([tableView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
    }
    
}
