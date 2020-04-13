//
//  CALayer+.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/14/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

extension CALayer {
    func applySketchShadow(
        color: UIColor = UIColor.lightGray.withAlphaComponent(0.4),
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 3,
        blur: CGFloat = 2,
        spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
