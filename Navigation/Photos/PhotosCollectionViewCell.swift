//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Александр Якубов on 22.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    var photoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(photoImage)
        self.addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.photoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.photoImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.photoImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImage.image = nil
    }

    func setup(photo: UIImage) {
        self.photoImage.image = photo
    }

}
