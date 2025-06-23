//
//  CountriesTableViewCell.swift
//  Countries
//
//  Created by Yenat Feyyisa on 4/1/25.
//

import UIKit

final class CountriesTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    private lazy var countryDetailsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var countryInfoCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        return view
    }()
//    MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpDynamicType()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        countryInfoCardView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
}
//  MARK: - setUp UI
extension CountriesTableViewCell {
    private func setUpCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(countryInfoCardView)
        countryInfoCardView.addSubview(countryDetailsStack)
        countryInfoCardView.addSubview(codeLabel)
        countryDetailsStack.addArrangedSubview(nameLabel)
        countryDetailsStack.addArrangedSubview(regionLabel)
        countryDetailsStack.addArrangedSubview(capitalLabel)
        
        NSLayoutConstraint.activate([
            countryInfoCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            countryInfoCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            countryInfoCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            countryInfoCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            countryDetailsStack.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countryDetailsStack.topAnchor.constraint(equalTo: countryInfoCardView.topAnchor, constant: 16),
            countryDetailsStack.trailingAnchor.constraint(equalTo: countryInfoCardView.trailingAnchor, constant: -16),
            countryDetailsStack.bottomAnchor.constraint(equalTo: countryInfoCardView.bottomAnchor, constant: -16),
            
            codeLabel.trailingAnchor.constraint(equalTo: countryInfoCardView.trailingAnchor, constant: -16),
            codeLabel.bottomAnchor.constraint(equalTo: countryInfoCardView.bottomAnchor, constant: -12)
        ])
    }
    func configure(with country: Country) {
        nameLabel.text = country.name
        regionLabel.text = country.region
        capitalLabel.text = "Capital: \(country.capital)"
        codeLabel.text = country.code
        configureAccessibility(with: country)
   }
}
// MARK: - configure accessibility
extension CountriesTableViewCell {
    func configureAccessibility(with country: Country) {
        isAccessibilityElement = true
        let accessibilityDescription = "\(country.name), region: \(country.region), capital: \(country.capital), code: \(country.code)"
        accessibilityLabel = accessibilityDescription
    }
    func setUpDynamicType() {
        nameLabel.adjustsFontForContentSizeCategory = true
        regionLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.adjustsFontForContentSizeCategory = true
        codeLabel.adjustsFontForContentSizeCategory = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        regionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .body)
        codeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    }
}

