//
//  DropDownTableViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 26/08/22.
//

import UIKit

enum ListItem: Hashable {
    case header(String)
    case myRow(Int)
}

class DropDownTableViewCell: UITableViewCell {
    let groupedNumbers = [
        (title: "ONE", numbers: Array(01...10))
    ]
    lazy var dataSource: UICollectionViewDiffableDataSource<String, ListItem> = {
        let cellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, ListItem> { (cell, _ , item) in
                switch item {
                case .header(let group):
                    var content = UIListContentConfiguration.plainHeader()
                    content.text = "SECTION \(group)"
                    cell.accessories = [.outlineDisclosure()]
                    cell.contentConfiguration = content
                case .myRow(let number):
                    var content = UIListContentConfiguration.cell()
                    content.text = number.formatted()
                    cell.accessories = []
                    cell.contentConfiguration = content
                }
        }
        let cellProvider: UICollectionViewDiffableDataSource<String, ListItem>
            .CellProvider = { collectionView, indexPath, item in
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
                return cell
        }
        return UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)
    }()
    private lazy var collectionView: UICollectionView = {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: UICollectionLayoutListConfiguration.Appearance.grouped)
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
        self.contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height*0.02
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            collectionView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.9
            ),
            collectionView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            )
        ])

        let heightConstraint = NSLayoutConstraint(
            item: collectionView,
            attribute: .height,
            relatedBy: .equal,
            toItem: .none,
            attribute: .notAnAttribute,
            multiplier: 0,
            constant: 200
        )
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
    }
    func configureViews() {
        collectionView.dataSource = dataSource
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 10
        groupedNumbers.forEach { (group, numbers) in
            let header = ListItem.header(group)
            let rows = numbers.map({ ListItem.myRow($0) })
            var snapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            snapshot.append([header])
            snapshot.append(rows, to: header)
            dataSource.apply(snapshot, to: group)
        }
        collectionView.backgroundColor = .green
    }
}
