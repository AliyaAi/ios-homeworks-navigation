//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Александр Якубов on 20.03.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell  {

    struct ViewModel {
        let author, description, image: String
        let likes, views: Int

    }

    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackViewPost: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var stackViewLikesAndViews: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = NSTextAlignment.left
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "System", size: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageNewView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "System", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "System", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.imageNewView.image = nil
        self.descriptionLabel.text = nil
        self.viewsLabel.text = nil
        self.likesLabel.text = nil
    }

    private func setupView() {

        contentView.backgroundColor = .white
        contentView.addSubview(backView)
        backView.addSubview(stackViewPost)
        stackViewPost.addArrangedSubview(authorLabel)
        stackViewPost.addArrangedSubview(imageNewView)
        stackViewPost.addArrangedSubview(descriptionLabel)
        stackViewPost.addArrangedSubview(stackViewLikesAndViews)
        stackViewLikesAndViews.addArrangedSubview(likesLabel)
        stackViewLikesAndViews.addArrangedSubview(viewsLabel)
        activateConstraints()
    }

    private func activateConstraints() {
        let backViewTop = backView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let backViewLead = backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let backViewTrail = backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let backViewBottom = backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        let stackViewPostTop = stackViewPost.topAnchor.constraint(equalTo: backView.topAnchor)
        let stackViewPostLead = stackViewPost.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16)
        let stackViewPostTrail = stackViewPost.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16)
        let stackViewPostBottom = stackViewPost.bottomAnchor.constraint(equalTo: backView.bottomAnchor)

        NSLayoutConstraint.activate([
            backViewTop, backViewLead, backViewTrail, backViewBottom , stackViewPostTop, stackViewPostLead, stackViewPostTrail, stackViewPostBottom
        ])
    }
    func setup(with viewModel: ViewModel) {
        self.authorLabel.text = viewModel.author
        self.imageNewView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.viewsLabel.text = "Views: " + String(viewModel.views)
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
    }
}
