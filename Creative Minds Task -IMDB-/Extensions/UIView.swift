//
//  UIView+Stacking.swift
//  LBTATools
//
//  Created by Brian Voong on 4/28/19.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

extension UIView {
    
    func HStack(_ views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillProportionally) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
    
    func VStack(_ views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillProportionally) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }
    
    @discardableResult
    open func withSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }
    
    @discardableResult
    open func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func withHeightAnchorWith(_ multiplier: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: superview!.heightAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    open func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    open func withWidthAnchorWith(_ multiplier: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
}

extension CGSize {
    static public func allSides(side: CGFloat) -> CGSize {
        return CGSize(width: side, height: side)
    }
}

extension UIView {
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func fillSuperviewSafeArea(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: -padding.right).isActive = true
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    @discardableResult
    func centerXInSuperview() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constX = centerXAnchor.constraint(equalTo: (superview?.centerXAnchor)!)
        constX.isActive = true
        return constX
    }
    
    @discardableResult
    func centerYInSuperview() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constY = centerYAnchor.constraint(equalTo: (superview?.centerYAnchor)!)
        constY.isActive = true
        return constY
    }
    
    @discardableResult
    func widthAnchorWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = widthAnchor.constraint(equalTo: (superview?.widthAnchor)!, multiplier: multiplier)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func heightAnchorWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = heightAnchor.constraint(equalTo: (superview?.heightAnchor)!, multiplier: multiplier)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func heightAnchorConstant(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = heightAnchor.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func widthAnchorConstant(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = widthAnchor.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = topAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.topAnchor)!, constant: constant)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func bottomAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = bottomAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.bottomAnchor)!, constant: constant)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func leadingAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: (superview?.leadingAnchor)!, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func leadingAnchorToTrailingSuperView(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func trailingAnchorAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: (superview?.trailingAnchor)!, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func trailingAnchorToLeadingSuperView(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func widthAnchorEqualHeightAnchor() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = widthAnchor.constraint(equalTo: heightAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func heightAnchorEqualWidthAnchor() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = heightAnchor.constraint(equalTo: widthAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topAnchorToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = topAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func bottomAnchorToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func trailingAnchorToView(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func leadingAnchorToView(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func centerYToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
}
