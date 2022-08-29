//
//  ImagesViewController.swift
//  Mars
//
//  Created by Robson Lima Lopes on 20/08/22.
// swiftlint

import UIKit

class ExploreViewController: UIViewController {
    private var photos: [Photo] = []
    private lazy var tableView: UITableView = {
        return UITableView()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.viewBackgroundColor
        applyViewCode()
        if CameraModel.cameraWasChanged {
            Task {
                self.photos = await CameraModel.getAllPhotos()
                tableView.reloadData()
            }
        }
    }
}

extension ExploreViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo:view.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo:view.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo:view.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo:view.bottomAnchor
            )
        ])
    }
    func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weatherCell")
//        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: "dropDownCell")
        tableView.register(PickerTableViewCell.self, forCellReuseIdentifier: "pickerCell")
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: "imagesCell")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = UIColor.viewBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CellType.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CellType.allCases[section] == .image {
            return photos.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = CellType.allCases[indexPath.section]
        switch currentItem {
        case .weather:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell")
                    as? WeatherTableViewCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            return cell
//        case .dropDown:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownCell")
//                    as? DropDownTableViewCell else {
//                fatalError("DequeueReusableCell failed while casting")
//            }
//            return cell
        case .picker:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pickerCell")
                    as? PickerTableViewCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            return cell
        case .image:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell")
                    as? ImagesTableViewCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            let photo = photos[indexPath.row]
            cell.configure(with: photo)
            return cell
        }
    }
}
