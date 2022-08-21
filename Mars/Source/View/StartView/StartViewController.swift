//
//  ViewController.swift
//  Mars
//
//  Created by Robson Lima Lopes on 20/08/22.
//

import UIKit

class StartViewController: UIViewController {
    
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.titleLabel?.font = button.titleLabel?.font.withSize(30)
        
        button.backgroundColor = UIColor(named: "AccentColor")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onTapStartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.viewBackgroundColor()
        
        view.addSubview(logoImageView)
        view.addSubview(startButton)
        
        loadConstraint()
    }
    
    
    func loadConstraint () {
        let logoImageConstraint = [
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: UIScreenSizes.width*0.9)
        ]
        
        let startButtonConstraint = [
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreenSizes.height*0.65),
            startButton.heightAnchor.constraint(
                equalToConstant: UIScreenSizes.height*0.07
            ),
            startButton.widthAnchor.constraint(
                equalToConstant: UIScreenSizes.width*0.7
            )
        ]
        
        NSLayoutConstraint.activate(logoImageConstraint)
        NSLayoutConstraint.activate(startButtonConstraint)
    }
    
    @objc func onTapStartButton() {
        
        let rootVC = ImagesViewController()
        
        let navVC = UINavigationController(rootViewController: rootVC)
        
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    
}
