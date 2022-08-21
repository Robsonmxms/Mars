//
//  ImagesViewController.swift
//  Mars
//
//  Created by Robson Lima Lopes on 20/08/22.
//

import UIKit

class ImagesViewController: UIViewController {
    
    let marsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Mars.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.viewBackgroundColor()
        
        view.addSubview(marsImageView)
        
        loadConstraint()
    }
    

    func loadConstraint () {
        let marsImageConstraint = [
            marsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            marsImageView.heightAnchor.constraint(
                equalToConstant: UIScreenSizes.height*0.35
            ),
            marsImageView.widthAnchor.constraint(
                equalToConstant: UIScreenSizes.width
            )
        ]
        
        NSLayoutConstraint.activate(marsImageConstraint)
    }

}
