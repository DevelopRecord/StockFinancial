//
//  CalcaulatorViewSecondCell.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/31.
//

import UIKit
import Combine

protocol CalcaulatorViewSecondCellDelegate: AnyObject {
    func pushViewController()
    func deliveryInvestmentIndex(index: Int)
}

class CalcaulatorViewSecondCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "CalcaulatorViewSecondCell"

    weak var delegate: CalcaulatorViewSecondCellDelegate?
    private var subscribers = Set<AnyCancellable>()

    var asset: Asset? {
        didSet { print("DEBUG: Asset 정보를 불러왔습니다.") }
    }
    
    @Published private var initialDateOfInvestmentIndex: Int?
    @Published private var initialInvestmentAmount: Int?
    @Published private var monthlyDollarCostAveragingAmount: Int?

    private lazy var stackView = UIStackView(arrangedSubviews: [verticalStackView, verticalStackView2, verticalStackView3]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
    }

    // 첫번째 스택뷰
    private lazy var verticalStackView = UIStackView(arrangedSubviews: [initialInvestmentAmountTextField, horizontalStackView]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let initialInvestmentAmountTextField = UITextField().then {
        $0.placeholder = "투자량을 입력해 주세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
        $0.keyboardType = .numberPad
        $0.borderStyle = .none
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [initialInvestmentLabel, unitKindLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let initialInvestmentLabel = UILabel().then {
        $0.text = "최초투자량"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private let unitKindLabel = UILabel().then {
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 두번째 스택뷰
    private lazy var verticalStackView2 = UIStackView(arrangedSubviews: [monthlyDollarCostAveragingAmountTextField, horizontalStackView2]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let monthlyDollarCostAveragingAmountTextField = UITextField().then {
        $0.placeholder = "월 달러 평균 금액을 입력해 주세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
        $0.keyboardType = .numberPad
        $0.borderStyle = .none
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private lazy var horizontalStackView2 = UIStackView(arrangedSubviews: [monthlyDollarCostAveragingAmountLabel, unitKindLabel2]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let monthlyDollarCostAveragingAmountLabel = UILabel().then {
        $0.text = "월 달러 평균 금액"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private let unitKindLabel2 = UILabel().then {
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 세번째 스택뷰
    private lazy var verticalStackView3 = UIStackView(arrangedSubviews: [initialDateOfInvestmentTextField, horizontalStackView3, dateSlider]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    let initialDateOfInvestmentTextField = UITextField().then {
        $0.placeholder = "최초 투자 일자를 입력해 주세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
        $0.borderStyle = .none
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private lazy var horizontalStackView3 = UIStackView(arrangedSubviews: [initialDateOfInvestmentLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let initialDateOfInvestmentLabel = UILabel().then {
        $0.text = "최초투자일자"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private let unitKindLabel3 = UILabel().then {
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    private lazy var dateSlider = UISlider().then {
        $0.tintColor = .systemGreen
        $0.addTarget(self, action: #selector(dateSliderDidChange), for: .valueChanged)
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureConstraints()
        setupTextFields()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configureUI() {
        contentView.backgroundColor = .secondarySystemBackground
    }

    private func configureConstraints() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    func configure(currency: String, dateSliderValue: Float, maximumValue: Float) {
        let unitKindArr = [unitKindLabel, unitKindLabel2]
        unitKindArr.forEach { labels in
            labels.text = currency.addBrackets()
        }
        dateSlider.value = dateSliderValue
        dateSlider.maximumValue = maximumValue
    }

    private func setupTextFields() {
        initialInvestmentAmountTextField.addDoneButton()
        monthlyDollarCostAveragingAmountTextField.addDoneButton()
        initialDateOfInvestmentTextField.delegate = self
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: initialInvestmentAmountTextField).compactMap({
            ($0.object as? UITextField)?.text
        }).sink { [weak self] text in
            self?.initialInvestmentAmount = Int(text) ?? 0
        }.store(in: &subscribers)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: monthlyDollarCostAveragingAmountTextField).compactMap({
            ($0.object as? UITextField)?.text
        }).sink { [weak self] text in
            self?.monthlyDollarCostAveragingAmount = Int(text) ?? 0
        }.store(in: &subscribers)
        
        Publishers.CombineLatest3($initialInvestmentAmount, $monthlyDollarCostAveragingAmount, $initialDateOfInvestmentIndex).sink { initialInvestmentAmount, monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex in
            print(initialInvestmentAmount, monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex)
        }.store(in: &subscribers)
    }

    // MARK: - Selectors

    @objc func dateSliderDidChange(sender: UISlider) {
        guard let asset = asset else { return }
        initialDateOfInvestmentIndex = Int(sender.value)
        let dateString = asset.timeSeriesMonthlyAdjusted.getMonthInfos()[initialDateOfInvestmentIndex ?? 0].date.YYMMFormat

        initialDateOfInvestmentTextField.text = dateString
        delegate?.deliveryInvestmentIndex(index: Int(sender.value))
    }
}

extension CalcaulatorViewSecondCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == initialDateOfInvestmentTextField {
            delegate?.pushViewController()
            return false
        }
        return true
    }
}
