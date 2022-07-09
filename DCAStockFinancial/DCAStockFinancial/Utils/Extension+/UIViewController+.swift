//
//  UIViewController+.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/09.
//

import UIKit

extension UIViewController {
    
    /// 네비게이션 설정 함수
    func setupNavigationBar(title: String, searchController: UISearchController) {
        navigationItem.searchController = searchController
        navigationItem.title = title
    }
}
