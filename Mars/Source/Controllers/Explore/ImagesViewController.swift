//
//  ImagesViewController.swift
//  Mars
//
//  Created by Robson Lima Lopes on 20/08/22.
//

import UIKit

class ExploreViewController: UIViewController{
    
    private let items: [CellType] = [
        .weather,
        .image
    ]
    
    private var photos: [Photo] = []
    
    
    
    private lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.viewBackgroundColor
    
        applyViewCode()
        
        Task {
            self.photos = await getAllPhotos()
            tableView.reloadData()
        }
    }
    
}

extension ExploreViewController: ViewCodeConfiguration{
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
            ),
            
        ])
    }
    
    func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weatherCell")
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: "imagesCell")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = UIColor.viewBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return photos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        
        
        let currentItem = items[indexPath.section]
        
        switch currentItem {
        case .weather:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherTableViewCell
            return cell
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imagesCell") as! ImagesTableViewCell
            let photo = photos[indexPath.row]
            cell.configure(with: photo)
            return cell
            
        }
    }
    
    func getAllPhotos() async -> [Photo] {
        let service = ImagesService()
        
        var model: RoverImagesModel?
        do{
            try await model = service.getImagesFromCamera(.chemcam)
        }catch{
            print(error)
        }
        
        return model?.photos ?? []
    }
    
}



