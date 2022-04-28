//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Александр Якубов on 20.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let author: String
        let description: String
        let image: String
        let likes: Int
        let views: Int
    }
    
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var postImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .white
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.authorLabel)
        self.backView.addSubview(self.postImageView)
        self.backView.addSubview(self.descriptionLabel)
        self.backView.addSubview(self.likesLabel)
        self.backView.addSubview(self.viewsLabel)
        self.setupView()
        self.setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.authorLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.postImageView.topAnchor, constant: -16),
            
            self.postImageView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor),
            self.postImageView.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -16),
            self.postImageView.heightAnchor.constraint(equalTo: self.postImageView.widthAnchor, multiplier: 1.0),
            
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
            
            self.likesLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likesLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16),
            
            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupGesture() {
        let tapLike = UITapGestureRecognizer(target: self, action: #selector(likeTapGesture(_:)))
        self.likesLabel.addGestureRecognizer(tapLike)
        
        let tapPostImage = UITapGestureRecognizer(target: self, action: #selector(imageTapGesture(_:)))
        self.postImageView.addGestureRecognizer(tapPostImage)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.postImageView.image = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }
    
    var likeDelegate: TapLikedDelegate?
    
    @objc func likeTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = self.likesLabel.next(PostTableViewCell.self), let indexPath = cell.indexPath else {
            return
        }
        self.likeDelegate?.updateLike(indexRow: indexPath.row)
    }
    
    var postDelegate: TapImagePostDelegate?
    
    @objc func imageTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = self.postImageView.next(PostTableViewCell.self), let indexPath = cell.indexPath else {
            return
        }
        self.postDelegate?.enlargePost(indexRow: indexPath.row)
    }
    
}

extension PostTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.authorLabel.text = viewModel.author
        self.postImageView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: " + String(viewModel.likes)
        self.viewsLabel.text = "Views: " + String(viewModel.views)
    }
}

