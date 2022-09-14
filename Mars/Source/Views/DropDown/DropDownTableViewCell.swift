//
//  DropDownTableViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 26/08/22.
//

import UIKit

enum ListItem: Hashable {
    case header(String)
    case myRow(String)
}

class DropDownTableViewCell: UITableViewCell {

    weak var delegate: DropDownCellDelegate!

    var dropDownConstraint: NSLayoutConstraint!

    var groupedCameras = [
        (title: "Select a Camera", cameras: CameraFullName.allCases)
    ]

    lazy var dataSource: UICollectionViewDiffableDataSource<String, ListItem> = {

        let cellRegistration = UICollectionView
            .CellRegistration<UICollectionViewListCell, ListItem> { (cell, _ , item) in
                switch item {
                case .header(let group):
                        var content = UIListContentConfiguration.prominentInsetGroupedHeader()
                    content.text = group
                    content.textProperties.color = .white
                    cell.accessories = [.outlineDisclosure()]
                    cell.contentConfiguration = content
                case .myRow(let number):
                    var content = UIListContentConfiguration.cell()
                    content.text = number
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
        self.dropDownConstraint.constant = dropDownConstraint.constant == 300 ? 50 : 300
        (self.superview as? UITableView)?.reloadRows(
            at: [IndexPath(row: 1, section: 0)],
            with: .automatic
        )
    }

    private lazy var collection: UICollectionView = {
        var layoutConfiguration = UICollectionLayoutListConfiguration(
            appearance: UICollectionLayoutListConfiguration.Appearance.insetGrouped
        )
        layoutConfiguration.backgroundColor = .darkGray
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

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let diff = collection.dataSource as?
                UICollectionViewDiffableDataSource<String, ListItem> else {
            return
        }
        let groupedCameras = groupedCameras[indexPath.section]
        var snapshot = diff.snapshot(for: groupedCameras.title)
        snapshot.collapse(snapshot.items)
        Task {
            await diff.apply(snapshot, to: groupedCameras.title)
            toggleSection()
            let selectedItem = groupedCameras.cameras[indexPath.item-1]
            let cameraName = CameraModel.cameraDict[selectedItem]
            await delegate?.loadImages(cameraName!)
        }

    }

}

extension DropDownTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.contentView.addSubview(collection)
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
        collection.translatesAutoresizingMaskIntoConstraints = false
        groupedCameras.forEach { (group, cameras) in
            let header = ListItem.header(group)
            let rows = cameras.map({ ListItem.myRow($0.rawValue) })
            var snapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            snapshot.append([header])
            snapshot.append(rows, to: header)
            dataSource.apply(snapshot, to: group)
        }
    }
}
