//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Александр Якубов on 22.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var photoImagesToGallery: UIImageView = {
        let photoImagesToGallery = UIImageView()
        photoImagesToGallery.clipsToBounds = true
        photoImagesToGallery.translatesAutoresizingMaskIntoConstraints = false
        
        return photoImagesToGallery
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backView)
        backView.addSubview(photoImagesToGallery)
        
        let backViewTop = backView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let backViewLead = backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let backViewTrail = backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let backViewBottom = backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        let photoImagesToGalleryCenterX = photoImagesToGallery.centerXAnchor.constraint(equalTo: backView.centerXAnchor)
        let photoImagesToGalleryCenterY = photoImagesToGallery.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        let photoImagesToGalleryHeight = photoImagesToGallery.heightAnchor.constraint(equalTo: backView.heightAnchor)
        let photoImagesToGalleryWidth = photoImagesToGallery.widthAnchor.constraint(equalTo: backView.widthAnchor)
        
        NSLayoutConstraint.activate([
            backViewTop, backViewLead, backViewTrail, backViewBottom, photoImagesToGalleryHeight, photoImagesToGalleryCenterX, photoImagesToGalleryCenterY, photoImagesToGalleryWidth
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
