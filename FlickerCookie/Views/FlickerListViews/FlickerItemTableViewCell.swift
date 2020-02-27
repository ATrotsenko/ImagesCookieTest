//
//  FlickerItemTableViewCell.swift
//  FlickerCookie
//
//  Created by Alexey on 24.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class FlickerItemTableViewCell: BaseTableViewCell {
    
    private var pictureImageView: UIImageView!
    private var autorLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!
    private var errorImage: UIImageView!
    
    weak var viewModel: FlickerTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func commonInit() {
        let pictureImageView = UIImageView()
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.clipsToBounds = true
        contentView.addSubview(pictureImageView)
        
        let heightConstraint = pictureImageView.heightAnchor.constraint(equalToConstant: 240)
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            heightConstraint,
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        self.pictureImageView = pictureImageView
        
        let autorLabel = UILabel()
        autorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(autorLabel)
        contentView.bringSubviewToFront(autorLabel)

        NSLayoutConstraint.activate([
            autorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            autorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            autorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        ])
        
        self.autorLabel = autorLabel
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicator)
        contentView.bringSubviewToFront(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        self.activityIndicator = activityIndicator
        
        let errorImage = UIImageView(image: UIImage(named: "ic_error"))
        errorImage.setColor(.red)
        errorImage.isHidden = true
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(errorImage)
        contentView.bringSubviewToFront(errorImage)
        
        NSLayoutConstraint.activate([
            errorImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            errorImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        self.errorImage = errorImage
    }
    
    private func updateView() {
        autorLabel.text = viewModel?.authorName
        pictureImageView?.setImageData(viewModel?.imageData)

        viewModel?.dataBlock = { [weak self] in
            self?.pictureImageView?.setImageData(self?.viewModel?.imageData)
        }
        
        viewModel?.stateBlock = { [weak self] (state) in
            self?.errorImage.isHidden = state != .error

            switch state {
            case .loading: self?.activityIndicator.startAnimating()
            case .success, .error: self?.activityIndicator.stopAnimating()
            }
        }
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        pictureImageView.image = nil
        autorLabel.text = nil
    }
}
