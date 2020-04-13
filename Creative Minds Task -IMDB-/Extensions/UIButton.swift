//
//  UIButton+.swift
//  Creative Minds Task -IMDB-
//
//  Created by Youssef on 4/13/20.
//  Copyright © 2020 Youssef. All rights reserved.
//

import UIKit

extension UIButton {
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    private struct AssociatedObjectKeyss {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    private typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    private var tapAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    //    // This is the meat of the sauce, here we create the tap gesture recognizer and
    //    // store the closure the user passed to us in the associated object we declared above
    func addTarget(action: (() -> Void)?) {
        tapAction = action
        addTarget(self, action: #selector(handleTapTarget), for: .touchUpInside)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc private func handleTapTarget(sender: UIButton) {
        if let action = self.tapAction {
            action?()
        } else {
            print("no action")
        }
    }
}
