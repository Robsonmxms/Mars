//
//  HeaderTableViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 23/08/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    private var soles: [Sole] = []
    private lazy var marsImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    private lazy var headerLabel: UILabel = {
        return UILabel(frame: .zero)
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.estimatedItemSize = CGSize(
            width: 120,
            height: 140
        )
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }()
    private lazy var footerLabel: UILabel = {
        return UILabel(frame: .zero)
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        Task {
            self.soles = await getAllSoles()
            collectionView.reloadData()
        }
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.contentView.addSubview(marsImageView)
        self.contentView.addSubview(headerLabel)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(footerLabel)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            marsImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            marsImageView.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.height*0.4
            ),
            marsImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor
            ),
            headerLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height*0.08
            ),
            headerLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: contentView.bounds.width * 0.1
            ),
            collectionView.topAnchor.constraint(
                equalTo: headerLabel.bottomAnchor,
                constant: headerLabel.bounds.height*0.01
            ),
            collectionView.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.6
            ),
            collectionView.widthAnchor.constraint(
                equalTo: marsImageView.widthAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: UIScreen.main.bounds.width*0.025
            ),
            footerLabel.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: collectionView.bounds.height*0.1
            ),
            footerLabel.leadingAnchor.constraint(
                equalTo: headerLabel.leadingAnchor
            )
        ])

        let bottomConstraint = marsImageView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor
        )
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true

    }
    func configureViews() {
        marsImageView.image = UIImage(named: "Mars.jpg")
        marsImageView.contentMode = .scaleAspectFill
        marsImageView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Weather"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        footerLabel.text = "Latest Weather at Gale Crater"
        footerLabel.textColor = .white
        footerLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension WeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return soles.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let model = soles[indexPath.item]
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as? WeatherCollectionViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.configure(with: model)
        return cell
    }
    func getAllSoles() async -> [Sole] {
        let service = WeatherService()
        var model: WeatherModel?
        do {
            try await model = service.getWeatherInfo()
        } catch {
            print(error)
        }
        return model?.soles ?? []
    }
}
