//
//  extension.swift
//  Navigation
//
//  Created by Александр Якубов on 12.04.2022.
//

import UIKit

extension UIResponder {
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        self.next as? T ?? self.next?.next(type)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPathForRow(at: self.center)
    }
}

extension UIView {
    
    func shake(count : Float = 3,for duration : TimeInterval = 0.3,withTranslation translation : Float = 3) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
