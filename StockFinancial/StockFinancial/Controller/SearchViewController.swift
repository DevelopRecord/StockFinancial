//
//  SearchViewController.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/29.
//

import UIKit

import SnapKit
import Then

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.rowHeight = 88
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
    }
    
    private lazy var searchController = UISearchController(searchResultsController: nil).then {
        $0.searchResultsUpdater = self
        $0.delegate = self
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "회사명이나 심볼 등을 검색해 보세요."
        $0.searchBar.autocapitalizationType = .allCharacters
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemRed
        configureConstraints()
    }
    
    func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell ?? SearchViewCell()
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

