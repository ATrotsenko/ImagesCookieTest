//
//  FlickerDescriptionViewController.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class FlickerDescriptionViewController: BaseViewController {
    private var pictureImageView: UIImageView!
    private var fileURLLabel: UILabel!
    
    var viewModel: FlickerDescriptionViewModel!
    
    convenience init(viewModel: FlickerDescriptionViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = viewModel.authorName
        
        let pictureImageView = UIImageView()
        pictureImageView.setImageData(viewModel.imageData)
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.clipsToBounds = true
        view.addSubview(pictureImageView)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                pictureImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                pictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pictureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                pictureImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                pictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pictureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
        
        let fileURLLabel = UILabel()
        fileURLLabel.text = viewModel.fileURL
        fileURLLabel.numberOfLines = 0
        fileURLLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fileURLLabel)

        NSLayoutConstraint.activate([
            fileURLLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 20),
            fileURLLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fileURLLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
