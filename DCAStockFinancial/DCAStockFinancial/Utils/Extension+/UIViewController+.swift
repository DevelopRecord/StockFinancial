//
//  UIViewController+.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/09.
//

import UIKit

extension UIViewController {

    /// 네비게이션 설정 함수
    func setupNavigationBar(title: String, searchController: UISearchController? = nil) {
        navigationItem.searchController = searchController
        navigationItem.title = title
    }

    /// 토스트 함수
    func showToast(message: String) {
        let width: CGFloat = 20
        let toastLabel = UILabel(frame: CGRect(x: width, y: self.view.frame.size.height - 160, width: view.frame.size.width - 2 * width, height: 55))
        // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
        toastLabel.backgroundColor = UIColor.systemGray5
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.boldSystemFont(ofSize: 20)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 3.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
                toastLabel.removeFromSuperview()
            })
    }
}
