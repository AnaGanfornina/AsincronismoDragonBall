//
//  UIImage + Extensions.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//


import UIKit
extension UIImageView {
    func loadImageRemote(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
