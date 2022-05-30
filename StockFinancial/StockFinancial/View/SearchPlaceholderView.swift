//
//  SearchPlaceholderView.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/30.
//

import UIKit

class SearchPlaceholderView: UIView {
    
    // MARK: - Properties
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "imDca")?.withTintColor(UIColor(named: "img_color")!)
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "기업에 투자하고 잠재적 수익을 계산할 회사를 검색해 보세요."
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
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(88)
            make.center.equalToSuperview()
        }
    }
}
