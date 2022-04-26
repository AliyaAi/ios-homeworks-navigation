//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 22.03.2022.
//

import UIKit
let image1 = UIImage(named: "1")
let image2 = UIImage(named: "2")
let image3 = UIImage(named: "3")
let image4 = UIImage(named: "4")
let image5 = UIImage(named: "5")
let image6 = UIImage(named: "6")
let image7 = UIImage(named: "7")
let image8 = UIImage(named: "8")
let image9 = UIImage(named: "9")
let image10 = UIImage(named: "10")
let image11 = UIImage(named: "11")
let image12 = UIImage(named: "12")
let image13 = UIImage(named: "13")
let image14 = UIImage(named: "14")
let image15 = UIImage(named: "15")
let image16 = UIImage(named: "16")
let image17 = UIImage(named: "17")
let image18 = UIImage(named: "18")
let image19 = UIImage(named: "19")
let image20 = UIImage(named: "20")

let photos = [image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15, image16, image17, image18, image19, image20]

class PhotosViewController: UIViewController {
    
    var closure: (() -> Void)?
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var transparent: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photo: UIImageView = {
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
        self.navigationItem.title = "Gallery"
        self.view.addSubview(self.photoCollectionView)
        self.view.addSubview(self.transparent)
        self.view.bringSubviewToFront(self.transparent)
        self.transparent.addSubview(self.crossButton)
        self.transparent.addSubview(self.photo)
        self.transparent.sendSubviewToBack(self.photo)
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.photoCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.transparent.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.transparent.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.transparent.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.transparent.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.crossButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.crossButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.photo.centerXAnchor.constraint(equalTo: self.transparent.centerXAnchor),
            self.photo.centerYAnchor.constraint(equalTo: self.transparent.centerYAnchor),
            self.photo.widthAnchor.constraint(equalTo: self.transparent.widthAnchor)
        ])
    }
    @objc private func didTapCross() {
        UIView.animate(withDuration: 0.3) {
            self.crossButton.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.transparent.alpha  = 0
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
        self.photo.image = self.dataSourcePhoto[indexPath.item]
        UIView.animate(withDuration: 0.5) {
            self.transparent.alpha  = 1.0
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.crossButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
}
