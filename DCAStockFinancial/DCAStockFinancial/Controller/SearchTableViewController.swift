//
//  SearchTableViewController.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/09.
//

import UIKit
import Combine
import Then
import MBProgressHUD

private enum Mode {
    case onboarding
    case search
}

class SearchTableViewController: UITableViewController, UIAnimatable {

    // MARK: - Properties

    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    private var searchResults: SearchResults?
    @Published private var mode: Mode = .onboarding
    @Published private var searchQuery = String()

    private lazy var searchController = UISearchController(searchResultsController: nil).then {
        $0.searchResultsUpdater = self
        $0.delegate = self
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "회사명이나 상호를 검색해 보세요."
        $0.searchBar.autocapitalizationType = .allCharacters
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "검색", searchController: searchController)
        setupTableView()
        observeForm()

    }

    // MARK: - Helpers

    private func setupTableView() {
        tableView.tableFooterView = UIView()
    }

    private func observeForm() {
        $searchQuery
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .sink { [unowned self] searchQuery in
            guard !searchQuery.isEmpty else { return }
            showLoadingAnimation()
            self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { completion in
                hideLoadingAnimation()
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { searchResults in
                self.searchResults = searchResults
                self.tableView.reloadData()
            }.store(in: &self.subscribers)
        }.store(in: &subscribers)

        $mode.sink { [unowned self] mode in
            switch mode {
            case .onboarding:
                self.tableView.backgroundView = SearchPlaceholderView()
            case .search:
                self.tableView.backgroundView = nil
            }
        }.store(in: &subscribers)
    }
}

extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? SearchTableViewCell ?? SearchTableViewCell()
        if let searchResults = searchResults {
            let searchResults = searchResults.items[indexPath.row]
            cell.configure(with: searchResults)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCalculator", sender: nil)
    }
}

extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else { return }
        self.searchQuery = searchQuery
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }
}
