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

    var dropDownConstraint: NSLayoutConstraint!

    let groupedNumbers = [
        (title: "SECTION ONE", numbers: Array(01...10))
    ]

    lazy var dataSource: UICollectionViewDiffableDataSource<String, ListItem> = {

        let cellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, ListItem> { (cell, _ , item) in
                switch item {
                case .header(let group):
                        var content = UIListContentConfiguration.prominentInsetGroupedHeader()
                    content.text = group
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

        let dataSource = UICollectionViewDiffableDataSource<String, ListItem>(
            collectionView: collection,
            cellProvider: cellProvider
        )

        dataSource.sectionSnapshotHandlers.willExpandItem = { [weak self] _ in
            self?.toggleSection()
        }

        dataSource.sectionSnapshotHandlers.willCollapseItem = { [weak self] _ in
            self?.toggleSection()
        }

        return dataSource
    }()

    func toggleSection() {
        self.dropDownConstraint.constant = dropDownConstraint.constant == 210 ? 50 : 210
        (self.superview as? UITableView)?.reloadRows(
            at: [IndexPath(row: 1, section: 0)],
            with: .automatic
        )
    }

    private lazy var collection: UICollectionView = {
        var layoutConfiguration = UICollectionLayoutListConfiguration(
            appearance: UICollectionLayoutListConfiguration.Appearance.grouped
        )
        layoutConfiguration.backgroundColor = .green
        layoutConfiguration.headerMode = UICollectionLayoutListConfiguration.HeaderMode.firstItemInSection
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        return collection
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

extension DropDownTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let diff = collection.dataSource as? UICollectionViewDiffableDataSource<String, ListItem> else {
            return
        }
        let groupedNumber = groupedNumbers[indexPath.section]
        var snapshot = diff.snapshot(for: groupedNumber.title)
        snapshot.collapse(snapshot.items)
        diff.apply(snapshot, to: groupedNumber.title)
        toggleSection()
    }
}

extension DropDownTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.contentView.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height*0.02
            ),
            collection.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])

        let heightConstraint = NSLayoutConstraint(
            item: collection,
            attribute: .height,
            relatedBy: .equal,
            toItem: .none,
            attribute: .notAnAttribute,
            multiplier: 0,
            constant: 50
        )
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        self.dropDownConstraint = heightConstraint
    }
    func configureViews() {
        collection.dataSource = dataSource
        collection.clipsToBounds = true
        collection.layer.cornerRadius = 10
        groupedNumbers.forEach { (group, numbers) in
            let header = ListItem.header(group)
            let rows = numbers.map({ ListItem.myRow($0) })
            var snapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            snapshot.append([header])
            snapshot.append(rows, to: header)
            dataSource.apply(snapshot, to: group)
        }
    }
}
