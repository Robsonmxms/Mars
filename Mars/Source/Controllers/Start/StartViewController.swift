//
//  ViewController.swift
//  Mars
//
//  Created by Robson Lima Lopes on 20/08/22.
//

import UIKit

class StartViewController: UIViewController {
    private lazy var logoImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    private lazy var startButton: UIButton = {
        return UIButton(frame: .zero)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.viewBackgroundColor
        applyViewCode()
    }
}

extension StartViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(startButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            logoImageView.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 0.9
            ),
            startButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            startButton.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.bounds.height*0.65
            ),
            startButton.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.07
            ),
            startButton.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 0.7
            )
        ])
    }
    func configureViews() {
        logoImageView.image = UIImage(named: "Logo.png")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(
            ofSize: 28,
            weight: .regular
        )
        startButton.backgroundColor = UIColor(named: "AccentColor")
        startButton.layer.cornerRadius = 10
        startButton.addTarget(
            self,
            action: #selector(onTapStartButton),
            for: .touchUpInside
        )
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }
    @objc private func onTapStartButton() {
        let rootVC = ExploreViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
