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
        
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        <#code#>
    }
}
