//
//  DropDownTableViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 26/08/22.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    private lazy var collectionView: UICollectionView = {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfiguration.headerMode = .firstItemInSection
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DropDownTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.addSubview(collectionView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: self.topAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
            collectionView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.9
            ),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func configureViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = UIColor.blue.cgColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DropDownTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CameraFullName.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let currentItem = CameraFullName.allCases[indexPath.section]
        var header = UIListContentConfiguration.plainHeader()
        header.text = "Select a camera"
        var content = UIListContentConfiguration.cell()
        content.text = currentItem.rawValue
        cell.contentConfiguration = content
        return cell
    }
}
