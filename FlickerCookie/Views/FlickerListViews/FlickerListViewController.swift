//
//  FlickerListViewController.swift
//  LoremflickrCookie
//
//  Created by Alexey on 24.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class FlickerListViewController: BaseViewController {
    private var tableView: UITableView!

    var viewModel: FlickerListViewModel!
    
    convenience init(viewModel: FlickerListViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.reload = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationControler()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)])
        
        tableView.registerWithoutXib(cls: FlickerItemTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupNavigationControler() {
        title = "Found items"
    }
}
