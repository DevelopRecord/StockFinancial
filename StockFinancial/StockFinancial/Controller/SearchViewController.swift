//
//  SearchViewController.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/29.
//

import UIKit
import Combine

import MBProgressHUD
import SnapKit
import Then

enum Mode {
    case onboarding
    case search
}

class SearchViewController: UIViewController, UIAnimatable {

    // MARK: - Properties

    private var subscribers = Set<AnyCancellable>()
    private var searchResults: SearchResponse?
    @Published private var searchQuery = String() // @Published는 쿼리 변수가 변경될 때마다 관찰할 수 있다는 의미
    @Published private var mode: Mode = .onboarding

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
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
        configureConstraints()
        setupNavigationBar()
        setupTableView()
        observeForm()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .secondarySystemBackground
    }

    func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
    }

    private func setupNavigationBar() {
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }

    private func observeForm() {
        $searchQuery.debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .sink { [unowned self] searchQuery in
                showLoadingAnimation()
            APIService.shared.fetchSymbolsPublisher(keywords: searchQuery).sink { completion in
                hideLoadingAnimation()
                switch completion {
                case .failure(let error):
                    print("데이터 가져오는 중 에러 발생 | \(error)")
                case .finished: break
                }
            } receiveValue: { searchResults in
                print("결과: \(searchResults), 개수: \(searchResults.items.count)")
                self.searchResults = searchResults
                self.tableView.reloadData()
            }.store(in: &self.subscribers) // subscriber 실행
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.identifier, for: indexPath) as? SearchViewCell ?? SearchViewCell()
        if let searchResults = self.searchResults {
            let searchResult = searchResults.items[indexPath.row]
            cell.configure(with: searchResult)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CalculatorViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else { return }
        self.searchQuery = searchQuery
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }
}

