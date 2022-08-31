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

extension ImagesTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.contentView.addSubview(photoFromAPIView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photoFromAPIView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: contentView.bounds.height*0.3
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
            )
        ])
    }
    func configureViews() {
        photoFromAPIView.contentMode = .scaleAspectFill
        photoFromAPIView.clipsToBounds = true
        photoFromAPIView.layer.cornerRadius = 25
        photoFromAPIView.translatesAutoresizingMaskIntoConstraints = false
    }
    func configure(with model: Photo) {
        let getUrl = model.imgSrc
        photoFromAPIView.imageFromServerURL(
            getUrl,
            placeHolder: placeHolder
        )
    }
}
