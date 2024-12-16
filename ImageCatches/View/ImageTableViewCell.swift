//
//  ImageTableViewCell.swift
//  ImageCatches
//
//  Created by Srikanth Kyatham on 12/9/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "ImageTableViewCell"
    private let thumbnailImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(thumbnailImageView)
            contentView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                thumbnailImageView.widthAnchor.constraint(equalToConstant: 50),
                thumbnailImageView.heightAnchor.constraint(equalToConstant: 50),
                
                titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageItem: ImageItem) {
            titleLabel.text = imageItem.title
            ImageDownloader.shared.getImage(url: imageItem.thumbnailUrl) { [weak self] image in
                self?.thumbnailImageView.image = image
            }
        }
    
}
