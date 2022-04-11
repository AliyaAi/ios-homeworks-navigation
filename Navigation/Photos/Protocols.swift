//
//  Protocols.swift
//  Navigation
//
//  Created by Александр Якубов on 12.04.2022.
//
import UIKit

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

protocol TapLikedDelegate {
    func updateLike(indexRow: Int)
}

protocol TapImagePostDelegate {
    func enlargePost(indexRow: Int)
}

protocol TapLikedPostDelegate {
    func updateLikePost()
}
