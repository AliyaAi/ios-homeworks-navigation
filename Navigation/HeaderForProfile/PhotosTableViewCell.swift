//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Александр Якубов on 22.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var photoStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.forward")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var photoImage1: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.image = photos[0]
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var photoImage2: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.image = photos[1]
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var photoImage3: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.image = photos[2]
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var photoImage4: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.image = photos[3]
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let widthPhoto = (UIScreen.main.bounds.width - 48) / 4

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(backView)
        self.backView.addSubview(photoLabel)
        self.backView.addSubview(arrowImage)
        self.backView.addSubview(photoStack)
        self.photoStack.addArrangedSubview(photoImage1)
        self.photoStack.addArrangedSubview(photoImage2)
        self.photoStack.addArrangedSubview(photoImage3)
        self.photoStack.addArrangedSubview(photoImage4)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            self.photoLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12),
            self.photoLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.photoLabel.bottomAnchor.constraint(equalTo: self.photoStack.topAnchor, constant: -12),
            self.arrowImage.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
            self.arrowImage.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),

            self.photoImage1.widthAnchor.constraint(equalToConstant: widthPhoto),
            self.photoImage2.widthAnchor.constraint(equalToConstant: widthPhoto),
            self.photoImage3.widthAnchor.constraint(equalToConstant: widthPhoto),
            self.photoImage4.widthAnchor.constraint(equalToConstant: widthPhoto),

            self.photoImage1.heightAnchor.constraint(equalTo: photoImage1.widthAnchor, multiplier: 0.8),
            self.photoImage2.heightAnchor.constraint(equalTo: photoImage2.widthAnchor, multiplier: 0.8),
            self.photoImage3.heightAnchor.constraint(equalTo: photoImage3.widthAnchor, multiplier: 0.8),
            self.photoImage4.heightAnchor.constraint(equalTo: photoImage4.widthAnchor, multiplier: 0.8),

            self.photoStack.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -12),
            self.photoStack.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.photoStack.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12)
        ])
    }
}
