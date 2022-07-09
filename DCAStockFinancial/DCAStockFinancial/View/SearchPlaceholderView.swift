//
//  SearchPlaceholderView.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/09.
//

import UIKit
import SnapKit

class SearchPlaceholderView: UIView {

    // MARK: - Properties

    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "imDca")?.withTintColor(.lightGray)
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel().then {
        $0.text = "투자할 기업이나 회사를 검색하고 예상 수익을 계산해 보세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private lazy var stackView = UIStackView(arrangedSubviews: [imageView, titleLabel]).then {
        $0.axis = .vertical
        $0.spacing = 24
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    private func configureConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.center.equalToSuperview()
            make.height.equalTo(88)
        }
    }
}
