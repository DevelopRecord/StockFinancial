//
//  UIViewController+.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/31.
//

import UIKit

extension UIViewController {

    /// 네비게이션 바 설정 함수
    func setupNavigationBar(title: String, largeTitles: Bool, searchController: UISearchController? = nil) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = largeTitles
        navigationItem.searchController = searchController

        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "nav_item_color")
    }
}
