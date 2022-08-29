//
//  WeatherCollectionViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 23/08/22.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    private lazy var solLabel: UILabel = {
        return UILabel(frame: .zero)
    }()
    private lazy var dateLabel: UILabel = {
        return UILabel(frame: .zero)
    }()
    private lazy var arrowUpImage: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    private lazy var maxTemp: UILabel = {
        return UILabel(frame: .zero)
    }()
    private lazy var arrowDownImage: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    private lazy var minTemp: UILabel = {
        return UILabel(frame: .zero)
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.7)
        self.layer.cornerRadius = UIScreen.main.bounds.height*0.012
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherCollectionViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.addSubview(solLabel)
        self.addSubview(dateLabel)
        self.addSubview(arrowUpImage)
        self.addSubview(maxTemp)
        self.addSubview(arrowDownImage)
        self.addSubview(minTemp)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            solLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: UIScreen.main.bounds.height*0.015
            ),
            solLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: self.bounds.width * 0.1
            ),
            dateLabel.topAnchor.constraint(
                equalTo: solLabel.bottomAnchor,
                constant: UIScreen.main.bounds.height*0.01
            ),
            dateLabel.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.8
            ),
            dateLabel.leadingAnchor.constraint(
                equalTo: solLabel.leadingAnchor
            ),
            arrowUpImage.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor,
                constant: UIScreen.main.bounds.height*0.02
            ),
            arrowUpImage.leadingAnchor.constraint(
                equalTo: dateLabel.leadingAnchor
            ),
            maxTemp.topAnchor.constraint(
                equalTo: arrowUpImage.topAnchor
            ),
            maxTemp.leadingAnchor.constraint(
                equalTo: arrowUpImage.trailingAnchor
            ),
            arrowDownImage.topAnchor.constraint(
                equalTo: arrowUpImage.bottomAnchor,
                constant: UIScreen.main.bounds.height*0.01
            ),
            arrowDownImage.leadingAnchor.constraint(
                equalTo: arrowUpImage.leadingAnchor
            ),
            minTemp.topAnchor.constraint(
                equalTo: arrowDownImage.topAnchor
            ),
            minTemp.leadingAnchor.constraint(
                equalTo: arrowDownImage.trailingAnchor
            )
        ])
    }
    func configureViews() {
        solLabel.textColor = .white
        solLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        solLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowUpImage.image = UIImage(systemName: "arrow.up")?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        arrowUpImage.translatesAutoresizingMaskIntoConstraints = false
        maxTemp.textColor = .white
        maxTemp.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        maxTemp.translatesAutoresizingMaskIntoConstraints = false
        arrowDownImage.image = UIImage(systemName: "arrow.down")?
            .withTintColor(.green, renderingMode: .alwaysOriginal)
        arrowDownImage.translatesAutoresizingMaskIntoConstraints = false
        minTemp.textColor = .white
        minTemp.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        minTemp.translatesAutoresizingMaskIntoConstraints = false
    }
    func configure(with model: Sole) {
        solLabel.text = "sol: \(model.sol)"
        dateLabel.text = FormatterModel.dateFormatter(model.terrestrialDate)
        maxTemp.text = ": \(model.maxTemp)º C"
        minTemp.text = ": \(model.minTemp)º C"
    }
}
