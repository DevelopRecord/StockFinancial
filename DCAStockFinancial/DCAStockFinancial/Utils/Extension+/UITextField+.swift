//
//  UITextField+.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/11.
//

import UIKit

extension UITextField {
    /// TextField 완료 버튼 추가 함수
    func addDoneButton() {
        let screenWidth = UIScreen.main.bounds.width
        let doneToolBar: UIToolbar = UIToolbar(frame: .init(x: 0, y: 0, width: screenWidth, height: 50))
        doneToolBar.barStyle = .default
        let flexBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(dismissKeyboard))
        let items = [flexBarButtonItem, doneBarButtonItem]
        doneToolBar.items = items
        doneToolBar.sizeToFit()
        inputAccessoryView = doneToolBar
    }

    @objc func dismissKeyboard() {
        resignFirstResponder()
    }
}
