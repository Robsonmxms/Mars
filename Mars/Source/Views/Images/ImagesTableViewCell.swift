//
//  ImagesTableViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 25/08/22.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    let placeHolder = UIImage(named: "ImageError")
    
    private lazy var photoFromAPIView: UIImageView = {
        return UIImageView()
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

extension ImagesTableViewCell: ViewCodeConfiguration{
    func buildHierarchy() {
        self.contentView.addSubview(photoFromAPIView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoFromAPIView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UIScreen.main.bounds.height*0.04
            ),
            photoFromAPIView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            photoFromAPIView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            photoFromAPIView.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.height*0.4
            ),
            photoFromAPIView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.9
            ),
            
        ])
    }
    
    func configureViews() {
        photoFromAPIView.contentMode = .scaleAspectFit
        photoFromAPIView.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        photoFromAPIView.layer.borderWidth = 5
        photoFromAPIView.layer.cornerRadius = 10
        photoFromAPIView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configure(with model: Photo){
        let url = model.imgSrc

        photoFromAPIView.imageFromServerURL(
            url,
            placeHolder: placeHolder)
        
    }
    
    
}
