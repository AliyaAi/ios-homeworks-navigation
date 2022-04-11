//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 22.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    var closure: (() -> Void)?

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()

    private lazy var transparentView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var enlargedPhoto: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(didTapCross), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var photoCollectionView: UICollectionView = {
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        photoCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        photoCollection.isUserInteractionEnabled = true
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        return photoCollection
    }()

    private var itemCount: CGFloat = 3
    private var dataSourcePhoto = photos

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backButtonTitle = "Back"
        self.navigationItem.title = "Photo Gallery"
        self.view.addSubview(self.photoCollectionView)
        self.view.addSubview(self.transparentView)
        self.view.bringSubviewToFront(self.transparentView)
        self.transparentView.addSubview(self.crossButton)
        self.transparentView.addSubview(self.enlargedPhoto)
        self.transparentView.sendSubviewToBack(self.enlargedPhoto)  // иначе на больших экранах фотка перекрывала кнопку закрытия
        self.setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .white

        NSLayoutConstraint.activate([
            self.photoCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            self.transparentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.transparentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.transparentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.transparentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.crossButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.crossButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            self.enlargedPhoto.centerXAnchor.constraint(equalTo: self.transparentView.centerXAnchor),
            self.enlargedPhoto.centerYAnchor.constraint(equalTo: self.transparentView.centerYAnchor),
            self.enlargedPhoto.widthAnchor.constraint(equalTo: self.transparentView.widthAnchor)
        ])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @objc private func didTapCross() {
        UIView.animate(withDuration: 0.3) {
            self.crossButton.alpha = 0
            self.view.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.transparentView.alpha  = 0
            self.view.layoutIfNeeded()
        }
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }

}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourcePhoto.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let photo = self.dataSourcePhoto[indexPath.row]
        cell.setup(photo: photo!)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (photoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: photoCollectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.enlargedPhoto.image = self.dataSourcePhoto[indexPath.item]
        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha  = 1.0
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.crossButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

}
